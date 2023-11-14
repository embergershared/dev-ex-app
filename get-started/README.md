# New developer setup

## Overview

As a new developer in the Contoso University app team, you are given access to a DevBox environment pre-configured to speed up your on-boarding.

The process to get started is:

1. Access the DevBox environment
2. Log in with your account
3. Create a DevBox machine (can take up to 45 minutes)
4. Clone the Contoso University app repo on your DevBox
5. Configure the Contoso University app on your DevBox
6. Develop, debug, etc.,
7. Turn the DevBox off.

## DevBox access

The DevBox machine is running in Azure. It can be accessed with:

- either [the DevBox web portal](https://devportal.microsoft.com/),
- or the remote desktop client:
  - [For Windows](https://learn.microsoft.com/en-us/azure/dev-box/tutorial-connect-to-dev-box-with-remote-desktop-app?tabs=windows#tabpanel_1_windows),
  - [For Non-Windows](https://learn.microsoft.com/en-us/azure/dev-box/tutorial-connect-to-dev-box-with-remote-desktop-app?tabs=windows#tabpanel_1_non-Windows).

## Log in with your work account

In both cases, you need to authenticate with your work microsoft account.

## Create a DevBox

Once logged-in, you can create a new DevBox by:

1. Do this
2. then that

> Note: The portal will also show your existing DevBox(es). In that, case, skip the rest of these instructions (they should be done already).

## Clone the Contoso University app repo

To get started, once connected to your DevBox:

- go in the folder:
- execute the script:

The script clones the application repo on the DevBox machine.

## Use the local app setup script

- in the locally cloned repository, go in the folder:
- execute the script:

The script:

- logs you in Azure,
- Generate basics `git` settings for your commits,
- Ask you to define a SQL Server administrator account,
- Create a Microsoft SQL Server 2022 container for your dev database,
- Wire the settings in the application for it to run right-away,
- Launch Visual Studio on the Contoso University App solution.
