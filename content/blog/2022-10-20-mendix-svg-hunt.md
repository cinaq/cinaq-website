---
title: "Mendix SVG Hunt"
date: 2022-10-20T13:37:00+01:00
draft: false
categories: ['Mendix', 'Hack']
tags: ['mendix', 'svg', 'mxbuild', 'docker', 'mendix-docker-buildpack', 'kubernetes', 'gitlab', 'ci']
authors: ['Xiwen Cheng']
description: Mxbuild fails to build due to SVG documents in the mendix model. You have removed all SVG's yet it does not solve the issue. Where the heck are these SVG's?
thumbnail: '/media/marc-schaefer-6NylLLcku8w-unsplash-thumb.jpg'
image: '/media/marc-schaefer-6NylLLcku8w-unsplash.jpg'

---

Today a client reached out to me with a mysterious case where the build pipeline of his Mendix app started to fail. He has just upgraded his app to Mendix 7.23.33 but was surprised it was not very smooth. As always I'm intrigued by out-of-ordinary problems. And this one turned out quite interesting.

## The error

As with most issues, it starts with a huge stacktrace. You can find this stacktrace in the appendix A. Reading stacktraces is almost like an art-form. Specially when we do not have the accompanying source code.

But not all is lost. With a bit of field experience as programmer and system engineer I concluded the problem is related to SVG:

```
  at Mendix.Modeler.Images.MxImage.ParseSvgDocument (byte[]) <0x0005b>
  at Mendix.Modeler.Images.MxImage.ParseImage (byte[]) <0x0016f>
  at Mendix.Modeler.Images.MxImage.set_ImageData (byte[]) <0x0004f>
```

The mxbuild process running inside of a Linux container with Mono is failing to parse an SVG document.

## Remove SVG's

With this finding I was super excited to share this solution with the client. Client proceeded to remove all SVG's from the app. However that did not resolve the problem. mxbuild is still failing.

## Where are the SVG's??

Somehow mxbuild is tripping over SVG's. Yet there are no SVG's to be found in the model anymore.

With my prior experience building [appsec](https://cinaq.com/appsec) and deep understanding of Mendix internals, I put my mechanics (reverse engineering?) skills to work.

I quickly drafted a tool in python to analyze the MPR file (mendix model) looking at the bits level. With this tool we found 3 SVG documents:

```
ERROR:root:{'$ID': b'l\x030\xd6\xeb\xa4 O\x90\xe4\xd7\xc4\xd3z<\xe0', '$Type': 'Images$Image', 'Image': b'<svg xmlns="http://www.w3.org/2000/svg"; width="81.844" height="52.083" viewBox="0 0 81.844 52.083">\r\n <path id="ic_people_24px" d="M56.8,27.321A11.161,11.161,0,1,0,45.642,16.161,11.114,11.114,0,0,0,56.8,27.321Zm-29.761,0A11.161,11.161,0,1,0,15.881,16.161,11.114,11.114,0,0,0,27.041,27.321Zm0,7.44C18.373,34.761,1,39.114,1,47.782v9.3H53.083v-9.3C53.083,39.114,35.709,34.761,27.041,34.761Zm29.761,0c-1.079,0-2.307.074-3.609.186,4.315,3.125,7.329,7.329,7.329,12.835v9.3H82.844v-9.3C82.844,39.114,65.471,34.761,56.8,34.761Z" transform="translate(-1 -5)" fill="#9c835d"/>\r\n</svg>\r\n', 'Name': 'GeneralInfo'}
ERROR:root:cannot identify image file <_io.BytesIO object at 0x159d43950>
ERROR:root:{'$ID': b"H1Y\xd4b\x17?A\x8c\xae\x18'M\x03v7", '$Type': 'Images$Image', 'Image': b'<svg xmlns="http://www.w3.org/2000/svg"; width="52.002" height="53" viewBox="0 0 52.002 53">\r\n <g id="Release_notes" data-name="Release notes" transform="translate(-1232 -6470)">\r\n <path id="ic_insert_drive_file_24px" d="M9.3,2A5.293,5.293,0,0,0,4.027,7.3L4,49.7A5.293,5.293,0,0,0,9.274,55H41.1a5.316,5.316,0,0,0,5.3-5.3V17.9L30.5,2ZM27.85,20.55V5.975L42.425,20.55Z" transform="translate(1228 6468)" fill="#9c835d"/>\r\n <path id="ic_edit_24px" d="M3,27.542V34H9.458L28.5,14.953,22.047,8.5ZM33.5,9.959a1.715,1.715,0,0,0,0-2.428L29.469,3.5a1.715,1.715,0,0,0-2.428,0L23.889,6.653l6.458,6.458L33.5,9.959Z" transform="translate(1250 6485.002)" fill="#425563"/>\r\n </g>\r\n</svg>\r\n', 'Name': 'Release_notes'}
ERROR:root:cannot identify image file <_io.BytesIO object at 0x159d43950>
ERROR:root:{'$ID': b'\xdf\xb6\x1f\xc3\xb9\x1e\xd6I\xbeG\xaa\xea3\x88\x1a\xdc', '$Type': 'Images$Image', 'Image': b'<?xml version="1.0" encoding="utf-8"?>\r\n<!-- Generator: Adobe Illustrator 23.0.1, SVG Export Plug-In . SVG Version: 6.00 Build 0) -->\r\n<svg version="1.1" id="Laag_1" xmlns="http://www.w3.org/2000/svg"; xmlns:xlink="http://www.w3.org/1999/xlink"; x="0px" y="0px"\r\n\t viewBox="0 0 52 48.32" style="enable-background:new 0 0 52 48.32;" xml:space="preserve">\r\n<style type="text/css">\r\n\t.st0{fill:#9D845E;}\r\n\t.st1{fill:#FFFFFF;}\r\n</style>\r\n<path class="st0" d="M0,48.32c-0.02-1.89,0.23-41.18,0.31-44.2C0.41,0.8,1.91-0.06,5.18,0c7.49,0.15,43.14,0,43.14,0\r\n\tS52,0.09,52,3.79c0,5.24,0,33.29,0,33.29s0,3.37-3,3.75c-3,0.37-41.57,0.37-41.57,0.37L0,48.32z"/>\r\n<rect x="23.74" y="7.14" class="st1" width="5.22" height="16.9"/>\r\n<rect x="23.74" y="27.24" class="st1" width="5.22" height="4.32"/>\r\n</svg>\r\n', 'Name': 'tooltip_brown_helpcenter'}
ERROR:root:cannot identify image file <_io.BytesIO object at 0x159d43950>
```

These 3 images are known with names:

- GeneralInfo
- Release_notes
- tooltip_brown_helpcenter

## SVG not found

Now also super excited I launched Mendix Studio, hit `ctrl+f` and typed `tooltip_brown_helpcenter`:

![Search for SVG document](/media/svg-document-search.png)

Hit `enter` and hit a wall:

![No results](/media/svg-document-not-found.png)

What the hell? Proceeded with the other 2 image names without results.

## We got this far, why stop here?

Remember we analyzed the MPR file? If we can read it, why not modify it? Great idea! The MPR file is `sqlite3` file. So we fire up sqlite3:

```sql
sqlite3 ~/Documents/Mendix/myapp/myapp.mpr
sqlite> .schema 
CREATE TABLE _MetaData(_ProductVersion TEXT,_BuildVersion TEXT,_SchemaHash TEXT);
CREATE TABLE Unit(UnitID BLOB NOT NULL,ContainerID BLOB,ContainmentName TEXT,TreeConflict LONG,ContentsHash TEXT,ContentsConflicts TEXT,Contents BLOB,PRIMARY KEY(UnitID));
```

`ContentsHash` looks interesting. We proceed to modify my tool to return the `ContentsHash` value when it fails to parse an image.

With this `ContentsHash` we can remove it from our MPR:

```sql
delete from Unit where ContentsHash = 'ubMSXQlsAv0hXeSMoMxKRhO0p1EaiflpQyg3ynKAQ/U=';
```

## It lives!

With MPR file modified, it's time to test! 

1. First off we open our modified MPR with Mendix Studio Pro. It passes the consistency check. Great!
2. Next up, does the local package creation work? Yes!
3. Finally, what about the pipeline run in Linux container? Bingo! See Appendix B.

## Summary

mxbuild running through Mono on Linux hosts sometimes cannot build Mendix models containing SVG documents embedded into the model. We have developed a tool to analyze the MPR file to determine what SVG documents are present that might not be visible in the Mendix Studio pro. Using this tool we can remove these hidden SVG documents from the model.

Should you do this? Probably not.

Aside from this little adventure, support for SVG is actually in Mendix. However for some unknown reason it does not work well with Mono in Linux. As a test the same troubling app was compiled with an experimental lab setup [cinaq/mendix-docker](https://github.com/cinaq/mendix-docker). There the project succeeds. With this I'm concluding there's a bug in [mendix-docker-buildpack](https://github.com/mendix/docker-mendix-buildpack) or in [cf-mendix-buildpack](https://github.com/mendix/cf-mendix-buildpack/)

Liked this post? Subscribe to this blog and/or follow us on social media. Links are at the bottom of this page.

## Appendix

### A: mxbuild stacktrace

```
INFO: Preflight check on Mendix version [7.23.33.54646] and stack [None]...
INFO: Preflight check completed
INFO: Building from source...
INFO: Selecting Mono Runtime: mono-4.6.2.16
   __  __      ____        _ _     _ 
  |  \/  |    |  _ \      (_) |   | |
  | \  / |_  _| |_) |_   _ _| | __| |
  | |\/| \ \/ /  _ <| | | | | |/ _` |
  | |  | |>  <| |_) | |_| | | | (_| |
  |_|  |_/_/\_\____/ \__,_|_|_|\__,_|
   v7.23.33.54646
Starting build for Mendix Project file: /opt/mendix/build/mxapp.mpr
Using the following options:
 * Build target: Package
 * Deployment package file: /tmp/model.mda
Reading project file...
* Assertion at local-propagation.c:330, condition `ins->opcode > MONO_CEE_LAST' not met
Stacktrace:
  at <unknown> <0xffffffff>
  at System.MemoryExtensions..cctor () <0x0000b>
  at (wrapper runtime-invoke) object.runtime_invoke_void (object,intptr,intptr,intptr) <0x00062>
  at <unknown> <0xffffffff>
  at Svg.SvgPropertyDescriptor`2<Svg.SvgFragment, Svg.SvgUnit>.SetValue (object,System.ComponentModel.ITypeDescriptorContext,System.Globalization.CultureInfo,object) <0x0007f>
  at Svg.SvgFragment.SetValue (string,System.ComponentModel.ITypeDescriptorContext,System.Globalization.CultureInfo,object) <0x0007c>
  at Svg.SvgDocument.SetValue (string,System.ComponentModel.ITypeDescriptorContext,System.Globalization.CultureInfo,object) <0x0010b>
  at Svg.SvgElementFactory.SetPropertyValue (Svg.SvgElement,string,string,string,Svg.SvgDocument,bool) <0x00096>
  at Svg.SvgElementFactory.SetAttributes (Svg.SvgElement,System.Xml.XmlReader,Svg.SvgDocument) <0x00473>
  at Svg.SvgElementFactory.CreateElement<T_REF> (System.Xml.XmlReader,bool,Svg.SvgDocument) <0x001a3>
  at Svg.SvgElementFactory.CreateDocument<T_REF> (System.Xml.XmlReader) <0x00067>
  at Svg.SvgDocument.Create<T_REF> (System.Xml.XmlReader) <0x00327>
  at Svg.SvgDocument.Open<T_REF> (System.IO.Stream,System.Collections.Generic.Dictionary`2<string, string>) <0x00117>
  at Svg.SvgDocument.Open<T_REF> (System.IO.Stream) <0x00027>
  at Mendix.Modeler.Images.MxImage.ParseSvgDocument (byte[]) <0x0005b>
  at Mendix.Modeler.Images.MxImage.ParseImage (byte[]) <0x0016f>
  at Mendix.Modeler.Images.MxImage.set_ImageData (byte[]) <0x0004f>
  at (wrapper runtime-invoke) <Module>.runtime_invoke_void__this___object (object,intptr,intptr,intptr) <0x000df>
  at <unknown> <0xffffffff>
  at (wrapper managed-to-native) System.Reflection.MonoMethod.InternalInvoke (System.Reflection.MonoMethod,object,object[],System.Exception&) <0x00073>
  at System.Reflection.MonoMethod.Invoke (object,System.Reflection.BindingFlags,System.Reflection.Binder,object[],System.Globalization.CultureInfo) <0x000a3>
  at System.Reflection.MonoProperty.SetValue (object,object,System.Reflection.BindingFlags,System.Reflection.Binder,object[],System.Globalization.CultureInfo) <0x00106>
  at System.Reflection.PropertyInfo.SetValue (object,object,object[]) <0x00040>
  at Mendix.Modeler.Storage.Operations.UnitContentsLoader.FillProperties (Mendix.Modeler.Storage.IStorageUnit,Mendix.Modeler.Storage.IStorageObject,Newtonsoft.Json.Linq.JObject,Mendix.Modeler.Storage.Caches.ICachedType) <0x00638>
  at Mendix.Modeler.Storage.Operations.UnitContentsLoader.ConstructObjectInternal (Mendix.Modeler.Storage.IStorageUnit,Mendix.Modeler.Storage.IStorageObject,Newtonsoft.Json.Linq.JObject) <0x00413>
  at Mendix.Modeler.Storage.Operations.UnitContentsLoader.ConvertFromStorage (Mendix.Modeler.Storage.IStorageUnit,Mendix.Modeler.Storage.IStorageObject,Mendix.Modeler.Storage.Caches.ICachedProperty,Newtonsoft.Json.Linq.JToken) <0x0016f>
  at Mendix.Modeler.Storage.Operations.UnitContentsLoader.FillProperties (Mendix.Modeler.Storage.IStorageUnit,Mendix.Modeler.Storage.IStorageObject,Newtonsoft.Json.Linq.JObject,Mendix.Modeler.Storage.Caches.ICachedType) <0x0059f>
  at Mendix.Modeler.Storage.Operations.UnitContentsLoader.ConstructObjectInternal (Mendix.Modeler.Storage.IStorageUnit,Mendix.Modeler.Storage.IStorageObject,Newtonsoft.Json.Linq.JObject) <0x00413>
  at Mendix.Modeler.Storage.Operations.UnitContentsLoader.ConstructUnitFromContents (Mendix.Modeler.Storage.IStorageUnit,byte[]) <0x0003f>
  at Mendix.Modeler.Storage.Operations.UnitLoader.ConstructUnit (Mendix.Modeler.Storage.IStorageUnit,System.Data.Common.DbDataReader) <0x0011f>
  at Mendix.Modeler.Storage.Operations.UnitLoader.LoadUnits (Mendix.Modeler.Storage.IStorageUnit,System.Collections.Generic.IList`1<System.Guid>) <0x00153>
  at Mendix.Modeler.Storage.Operations.UnitLoader.LoadChildUnits (Mendix.Modeler.Storage.IStorageUnit) <0x006f7>
  at Mendix.Modeler.Storage.Operations.UnitLoader.LoadChildUnits (Mendix.Modeler.Storage.IStorageUnit) <0x00b6f>
  at Mendix.Modeler.Storage.Operations.UnitLoader.Load<T_REF> (Mendix.Modeler.Utility.Progress.IProgressInfo,System.Collections.Generic.Dictionary`2<System.Guid, Mendix.Modeler.Storage.IStorageUnit>) <0x00337>
  at Mendix.Modeler.Storage.Database.Load<T_REF> (Mendix.Modeler.Utility.Progress.IProgressInfo,System.Collections.Generic.Dictionary`2<System.Guid, Mendix.Modeler.Storage.IStorageUnit>,bool) <0x0006b>
  at Mendix.MxBuild.ProjectLoader/<>c__DisplayClass9_0.<LoadProject>b__0 (Mendix.Modeler.Storage.Database) <0x00083>
  at Mendix.Modeler.Storage.Database/<>c__DisplayClass24_0`1<TResult_REF>.<Do>b__0 (Mendix.Modeler.Utility.DbConnectors.IDbConnector) <0x00058>
  at Mendix.Modeler.Utility.DbConnectors.SQLiteConnector/<>c__DisplayClass5_0`1<TResult_REF>.<Do>b__1 () <0x00021>
  at Mendix.Modeler.Utility.DbConnectors.DbConnector.WithoutTransactionDo<TResult_REF> (System.Func`1<TResult_REF>) <0x00022>
  at Mendix.Modeler.Utility.DbConnectors.SQLiteConnector.Do<TResult_REF> (string,bool,System.Func`2<Mendix.Modeler.Utility.DbConnectors.IDbConnector, TResult_REF>) <0x00217>
  at Mendix.Modeler.Storage.Database.Do<TResult_REF> (string,bool,System.Func`2<Mendix.Modeler.Storage.Database, TResult_REF>) <0x0011b>
  at Mendix.MxBuild.ProjectLoader.LoadProject (string,System.Collections.Generic.Dictionary`2<System.Guid, Mendix.Modeler.Storage.IStorageUnit>) <0x0010f>
  at Mendix.MxBuild.ProjectLoader.Load (string,bool,bool) <0x005db>
  at Mendix.MxBuild.BuildRunner.Execute (Mendix.MxBuild.IBuildOptions) <0x001c9>
  at Mendix.MxBuild.BuildRunnerMode.ExecuteBuild (Mendix.MxBuild.IBuildOptions) <0x0006b>
  at Mendix.MxBuild.BuildRunnerMode.Run (System.Collections.Generic.IList`1<string>) <0x0008f>
  at Mendix.MxBuild.ApplicationRunner.Run (System.Collections.Generic.IEnumerable`1<string>) <0x00194>
  at Mendix.MxBuild.Program/<>c__DisplayClass1_0.<Main>b__0 (Mendix.MxBuild.IApplicationRunner) <0x0002c>
  at Mendix.CommandLine.Shared.ProgramHelper.InitializeAndRun<T_REF> (System.Func`2<T_REF, int>,System.Reflection.Assembly[]) <0x00085>
  at Mendix.MxBuild.Program.Main (string[]) <0x0017f>
  at (wrapper runtime-invoke) <Module>.runtime_invoke_int_object (object,intptr,intptr,intptr) <0x000fd>
Native stacktrace:
	/tmp/opt/mono-4.6.2.16/bin/mono(+0xa7394) [0x562b62c79394]
	/lib/x86_64-linux-gnu/libpthread.so.0(+0x12980) [0x7f7c4412b980]
	/lib/x86_64-linux-gnu/libc.so.6(gsignal+0xc7) [0x7f7c43b4ee87]
	/lib/x86_64-linux-gnu/libc.so.6(abort+0x141) [0x7f7c43b507f1]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0x25e733) [0x562b62e30733]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0x25e4cd) [0x562b62e304cd]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0x25e681) [0x562b62e30681]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0x98421) [0x562b62c6a421]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0x103c7a) [0x562b62cd5c7a]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0x104789) [0x562b62cd6789]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0x39641) [0x562b62c0b641]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0xa8f4a) [0x562b62c7af4a]
	/tmp/opt/mono-4.6.2.16/bin/mono(+0xa968c) [0x562b62c7b68c]
	[0x408e6398]
Debug info from gdb:
=================================================================
Got a SIGABRT while executing native code. This usually indicates
a fatal error in the mono runtime or one of the native libraries 
used by your application.
=================================================================
ERROR: Could not read MxBuild error file
Traceback (most recent call last):
  File "/opt/mendix/buildpack/buildpack/mxbuild.py", line 57, in build_from_source
    subprocess.check_call(args, env=mono_env)
  File "/usr/lib/python3.6/subprocess.py", line 311, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['/tmp/opt/mono-4.6.2.16/bin/mono', '--config', '/tmp/opt/mono-4.6.2.16/etc/mono/config', '/opt/mendix/build/.local/mxbuild/modeler/mxbuild.exe', '--target=package', '--output=/tmp/model.mda', '--java-home=/opt/mendix/build/.local/usr/lib/jvm/AdoptOpenJDK-jdk-8u282-AdoptOpenJDK-x64', '--java-exe-path=/opt/mendix/build/.local/usr/lib/jvm/AdoptOpenJDK-jdk-8u282-AdoptOpenJDK-x64/bin/java', '--write-errors=/tmp/builderrors.json', '/opt/mendix/build/mxapp.mpr']' died with <Signals.SIGABRT: 6>.
During handling of the above exception, another exception occurred:
Traceback (most recent call last):
  File "/opt/mendix/buildpack/buildpack/mxbuild.py", line 104, in _log_buildstatus_errors
    with codecs.open(error_file, "r", encoding="utf-8-sig") as errorfile:
  File "/usr/lib/python3.6/codecs.py", line 897, in open
    file = builtins.open(filename, mode, buffering)
FileNotFoundError: [Errno 2] No such file or directory: '/tmp/builderrors.json'
ERROR: MxBuild returned errors: {"problems": [{"severity": "Error", "message": "Failed to build the model,please check application logs for details.", "locations": []}]}
ERROR: Command '['/tmp/opt/mono-4.6.2.16/bin/mono', '--config', '/tmp/opt/mono-4.6.2.16/etc/mono/config', '/opt/mendix/build/.local/mxbuild/modeler/mxbuild.exe', '--target=package', '--output=/tmp/model.mda', '--java-home=/opt/mendix/build/.local/usr/lib/jvm/AdoptOpenJDK-jdk-8u282-AdoptOpenJDK-x64', '--java-exe-path=/opt/mendix/build/.local/usr/lib/jvm/AdoptOpenJDK-jdk-8u282-AdoptOpenJDK-x64/bin/java', '--write-errors=/tmp/builderrors.json', '/opt/mendix/build/mxapp.mpr']' died with <Signals.SIGABRT: 6>.
Traceback (most recent call last):
  File "./compilation", line 65, in <module>
    exit_code = call_buildpack_compilation()
  File "./compilation", line 37, in call_buildpack_compilation
    return subprocess.check_call(["/opt/mendix/buildpack/buildpack/stage.py", BUILD_PATH, CACHE_PATH])
  File "/usr/lib/python3.6/subprocess.py", line 311, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['/opt/mendix/buildpack/buildpack/stage.py', '/opt/mendix/build', '/tmp/buildcache']' returned non-zero exit status 1.
error building image: error building stage: failed to execute command: waiting for process to exit: exit status 1
```


### B: mxbuild succeeds

```
INFO: Preflight check on Mendix version [7.23.33.54646] and stack [None]...
INFO: Preflight check completed
INFO: Building from source...
INFO: Selecting Mono Runtime: mono-4.6.2.16
   __  __      ____        _ _     _ 
  |  \/  |    |  _ \      (_) |   | |
  | \  / |_  _| |_) |_   _ _| | __| |
  | |\/| \ \/ /  _ <| | | | | |/ _` |
  | |  | |>  <| |_) | |_| | | | (_| |
  |_|  |_/_/\_\____/ \__,_|_|_|\__,_|
   v7.23.33.54646
Starting build for Mendix Project file: /opt/mendix/build/myapp.mpr
Using the following options:
 * Build target: Package
 * Deployment package file: /tmp/model.mda
Reading project file...
Building project...
Executing step 'Synchronize with file system'
 * Synchronizing with file system...
libpng warning: iCCP: known incorrect sRGB profile
libpng warning: iCCP: known incorrect sRGB profile
libpng warning: iCCP: known incorrect sRGB profile
libpng warning: iCCP: known incorrect sRGB profile
libpng warning: iCCP: known incorrect sRGB profile
Executing step 'Initialize'
 * Preparing deployment...
Executing step 'Check prerequisites'
 * Checking for errors...
Executing step 'Clean deployment directory'
 * Cleaning deployment directory...
 * Cleaning web deployment directory...
Executing step 'Prepare deployment'
 * Writing files...
Executing step 'Build deployment structure'
 * Compiling Java...
 * Generating integration files...
 * Exporting a theme...
 * Exporting pages...
 * Optimizing...
 * Exporting custom widgets...
 * Bundling custom widgets...
 * Compressing web resources...
Executing step 'Save model to deployment directory'
 * Saving model to deployment directory...
Executing step 'Create deployment package'
 * Creating deployment package...
Executing step 'Finalize deployment package'
BUILD SUCCEEDED
```