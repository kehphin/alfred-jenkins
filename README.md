# alfred-jenkins
Alfred 3 Plugin for Jenkins

![alfred-jenkins](https://i.imgur.com/ZVszJQs.png)
This Plugin allows you to search for projects within your Jenkins system. When selected, it will open up a new browser tab to that project within Jenkins.

**Note: This requires you to be logged into Jenkins in the browser.**

## Usage

1. Go to [Releases](https://github.com/kehphin/alfred-jenkins/releases) and download the latest `.alfredworkflow` release.
2. Open and save in Alfred 3.
3. Set your Jenkins Url, User Id and API Token via the `jksetup` command. E.g. `jksetup https://jenkins-hostname.com username123 password456`. This data is stored locally on your machine at `Library/Application Support/Alfred 3/Workflow Data/app.kevinyang.jenkins.alfredworkflow`.
4. Use the `jk` command to your liking!

## Development
1. Clone this repository in the folder: `~/Library/Application\ Support/Alfred\ 3/Alfred.alfredpreferences/workflows/`
2. Go to the Workflows tab in Alfred Preferences
3. Toggle debugging mode on the top right (Bug icon)
4. Develop in the source code to your liking!
