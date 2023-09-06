# Response Generator

<br>

<div align="center">
  <img src="https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/bce61c2d-f08e-4cff-ab33-6360bdffd6e8/denzqn3-44426b90-aab9-4983-bf88-cf297521e1a5.png/v1/fill/w_1280,h_800,strp/darkmyst_powershell_wallpaper__2560x1600__by_bastardoperator_denzqn3-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9ODAwIiwicGF0aCI6IlwvZlwvYmNlNjFjMmQtZjA4ZS00Y2ZmLWFiMzMtNjM2MGJkZmZkNmU4XC9kZW56cW4zLTQ0NDI2YjkwLWFhYjktNDk4My1iZjg4LWNmMjk3NTIxZTFhNS5wbmciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.hvmE-eBBFunU5E_HAn-CCLNKA1Y_DLpE0xlUqtTYCK4" height=400 width="100%"/>
</div>
<div align="center">
  <h4><b>A simple Windows form utility for generating quick response messages</b></h4>
</div>

<br>

## About 🗃

As IT Support Professionals, we are constantly sending correspondance to various clients and end users. 
Very rarely do we help only one or two customer groups each day, and because of that fact, it's normal 
for us to have to create tailored response messages with contact info specific to that client.

<br>

> This repository is meant to supplement the <a>Medium article</a>: **"Using PowerShell Forms for Repetitive Tasks"**

<br>

## Getting Started 🖥

The utility was designed as straightforward, custom module meant to be easily imported into a `powershell` session
and invoked by the user. In order for this module to be imported, it's important to locate the designated system path 
to place this project's inner directory in. The easiest way to find that location is by opening a powershell terminal 
and typing the following:

```powershell
PS > $env:PSModulePath
```

Once the module (`ResponseGenerator`) folder has been placed in the above directory, it can be imported and run from any future powershell 
sessions by simply running `Import-Module ResponseGenerator`. 

**Newer PowerShell versions automatically import any custom modules located in `$env:PSModulePath`. This means all a user has to do is simply invoke the function from their session**.

<br>

## Example 💡


```powershell
# import the custom module
PS > Import-Module ResponseGenerator

# start the utility by calling it's invoke method
PS > Invoke-ResponseGenerator
```

<br>

<div align="center">
  <img src="response_generator.png" />
</div>

<br>

> **NOTE:**
> 
> The dimensions of the form rendered on your device may not match with the devices tested on during the creation of this utility.
> 
> If any of the buttons or test fail to render properly on your device, you may need to simply update the `height` and `width` values of the component that needs corrected.

<br>

## License 🔒

**See LICENSE.md**

