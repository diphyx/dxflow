The purpose of `profiles` is to create a set for environmental variables that can be used to configure the dxflow engine. This allows you to easily switch between different configurations without having to manually set the environmental variables each time.
It is especially useful when you want to connect to different dxflow engines or when you want to use different configurations for different workflows.

IF you don't want to use profile you can set the environmental variables directly in your shell or in your workflow file. The `profiles` are just a convenient way to manage the environmental variables. The 

{{< callout type="info" emoji="🔧" >}}
All the config variables can be set in the Environment by using Environment case method (all capital with _ instead of -).
{{</ callout >}}


define profile: 
```bash
dxflow.exe -C <PROFILE_NAME> config <variable> <value>
```
Profiles information are stored at `~/.dxflow/PROFILE_NAME_config.yaml`, if you want to remove the profile from your dxflow, you can just delete the file manually. 

There are several variables that can be set in the profile, such as:
* `http-port`: The port on which the dxflow engine will listen for HTTP requests. Default is `80`.
* `connection-address`: The (IP) address of the dxflow engine. Default is `0.0.0.0`.
* `volume`: The volume where the dxflow engine will store its data. Default is `~/.dxflow` for Linux and MacOS, and `C:\ProgramData\dxflow` for Windows.
* `secret`: dxflow generate a secret key everytime use run it. To use a constant secret key, you can define it in the config file or environment variable.
{{< callout type="warning" >}}
This method is not recommended for production use, as it is not secure.We suggest to use use the default method as its secrets have expiration time.
{{</ callout >}}
```bash
dxflow.exe config secret <secret>
```

In order to remove a config use `unset` command:
```bash
dxflow.exe -C <PROFILE_NAME> config unset <variable>
```
{{< callout type="info" emoji="🔧" >}}
If you don't use the `-C` flag, the default profile will be used. The default profile is created automatically when you run the `dxflow` command for the first time. You can also create a new profile by using the `-C` flag with any name you want.
{{</ callout >}}