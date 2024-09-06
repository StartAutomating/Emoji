# Thank you Microsoft!  Thank you PowerShell!  Thank you Docker!
FROM mcr.microsoft.com/powershell

# Set the shell to PowerShell
SHELL ["/bin/pwsh", "-nologo", "-command"]
# Next we will do the following:
# 1. Update and Install any packages
# 2. Create a profile if it does not exist
# 3. Add the module to the profile
# 4. Install additional modules
# 5. Add the additional modules to the profile
# 6. Add the microservice start to the profile
# 7. Clean up
RUN --mount=type=bind,src=./,target=/Initialize ./Initialize/Container.init.ps1
# We want to do this in one RUN command:
# It keeps the image smaller, and minimizes the number of layers.