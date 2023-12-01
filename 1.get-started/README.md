# New developer setup

## Overview

As a new developer in the Contoso University app team, you are given access to a DevBox environment pre-configured to speed up your on-boarding.

The process to get started is:

1. Access the DevBox environment
2. Log in with your account
3. Create a DevBox machine (can take up to 45 minutes)
4. Install development tooling
5. Get and configure the Contoso University app on your DevBox
6. Develop, debug, etc.,
7. Turn the DevBox off.

## Steps

### 1. DevBox access

The DevBox machine is running in Azure. It can be accessed with:

- either [the DevBox web portal](https://devportal.microsoft.com/),
- or the remote desktop client:
  - [For Windows](https://learn.microsoft.com/en-us/azure/dev-box/tutorial-connect-to-dev-box-with-remote-desktop-app?tabs=windows#tabpanel_1_windows),
  - [For Non-Windows](https://learn.microsoft.com/en-us/azure/dev-box/tutorial-connect-to-dev-box-with-remote-desktop-app?tabs=windows#tabpanel_1_non-Windows).

### 2. Log in with your work account

In both cases, you need to authenticate with your work microsoft account.

### 3. Create a DevBox

Go to the [DevBox web portal](https://devportal.microsoft.com/) and log in.

Once logged-in, you can either:

  - `Start`, `Stop`, `Delete`, `Log in` an existing dev box(es),

or:

  - `Create` a new Dev box:

      1. Click the `+ New dev box` button

      ![New dev box](../assets/db-newdb-button.png)

      2. Add a new dev box entering a `Name` and selecting a `Dev box pool`

      ![Add dev box](../assets/db-newdb-add.png)

      3. Click `Create`

      4. Go grab lunch, coffee, etc.

      5. See [Dev box access](#1-devbox-access) to log in to the new box, once created and `Running`.

### 4. Install tooling

1. Download the script: [1-install-tooling.ps1](https://github.com/embergershared/dev-ex-app/blob/main/1.get-started/1-install-tooling.ps1) (Suggestion: Open in a new tab)

2. Choose `Keep` when asked

![Keep install script](../assets/keep-1-install-tooling.png)

3. Launch a terminal **AS Administrator**

![Terminal run as admin](../assets/run-as-admin.png)

4. Execute these commands:

      ```powershell
      # Launch the downloaded script:
      Set-Location $HOME\Downloads
      Set-ExecutionPolicy Bypass -Force
      .\1-install-tooling.ps1

      ```

5. Finish Docker desktop install

      Docker desktop gets installed, but requires UI last steps:

      - Launch the shortcut on the Desktop,

        ![Docker desktop](../assets/docker-desktop-launch.png)

      - `Accept` the Service Agreement,
      - `Sign up`, `Sign in` or `Continue without signing in` - up to you,
      - `Fill` or `Skip` about your role - up to you,
      - go to settings (gear in top right) and check enable `General` / `Start Docker Desktop when you log in`,
      - `Apply & restart`,
      - Check `Engine running` status.

      > Note: you may need to restart the Dev box for full effect.

### 5. Get and configure the app

1. Download the script: [2-app-local-setup](https://github.com/embergershared/dev-ex-app/blob/main/1.get-started/2-app-local-setup.ps1) (Suggestion: Open in a new tab)

![Keep setup script](../assets/keep-2-app-local-setup.png)

2. Launch a terminal

3. Execute these commands:

      ```powershell
      # Launch the downloaded script:
      Set-Location $HOME\Downloads
      .\2-app-local-setup.ps1

      ```

      The script:

      - Clones the app repo locally,
      - Logs you in Azure,
      - Generate basics `git` settings for your commits,
      - Your input is required:

        - To set a local container SQL Server administrator account,

        ![SQL sa password prompt](../assets/sql-container-sapwd-prompt.png)

      - Create a Microsoft SQL Server 2022 container for your dev database,
      - Wire the settings in the application for it to use the local container SQL Server,
      - Launch Visual Studio on the Contoso University App solution.

4. Sign in to Visual Studio

5. Success looks like:

![Success VS launch](../assets/vs-launch-success.png)

### 6. Develop, test, create a PR

Development work, with Github Copilot help.

Here are some getting started suggested steps:

1. Populate the database with data:

      - Set startup project to the API:

      ![Set on API](../assets/vs-set-to-api.png)

      - Start the API:

      ![Start the API](../assets/vs-start-api.png)

      - Browse to the Swagger UI: [https://localhost:58372/swagger](https://localhost:58372/swagger)

      ![WebAPI Swagger UI](../assets/vs-api-swagger.png)

2. Configure APP and API to start together:

      - Go to configure Startup Projects:

      ![Configure Startup](../assets/vs-configure-startup.png)

      - Set Startup for both APP and API:

      ![Multi project Startup](../assets/vs-multiproj-startup.png)

      - Click `Start`:

      ![Start multi-projects](../assets/vs-start-multiproj.png)

      - Success looks like:

          - Home page:

            ![Success1](../assets/vs-multiproj-success1.png)

          - Students list:

            ![Success2](../assets/vs-multiproj-success2.png)

          - Student details with embedded courses' list:

            ![Success3](../assets/vs-multiproj-success3.png)

### 7. Shutdown the Dev box

1. Go to the [DevBox web portal](https://devportal.microsoft.com/)

2. On the dev box tile:

   - Click on the "3 dots"

   - Select `Shut down`

   ![shutdown](../assets/shut-down-devbox.png)
