# The Zebra: Robot Framework Integrated Tests
<br/>


## Overview
This repository contains the code and resources for running integrated tests for TheZebra.com via the open-source Robot Framework. The suite offers both functional and scenario UI testing as well as a suite of Robot keywords for developing additional Robot/Selenium based UI tests.
____


## Usage

#### *Requirements*
To maximize portability, the test environment and runtime have been Dockerized. Thus, the only requirements to run this test suite are as follows

* Git
* The latest version of Docker.
* This repository

Note that bash test run scripts have been provided to assist in test execution, so these tests should ideally be executed on a compatible Unix-based operating system.  All other dependencies are contained within the Dockerfile itself.

<br/>

#### *Instructions*

To begin, first ensure that you have the latest versions of:
<br/>
* `Git`
* `Docker`
<br/>

installed. You can verify that Git is installed by running the command:
<br/>
<br/>
`git`
<br/>
<br/>
which should return output akin to:
<br/>
<br/>
```
usage: git [--version] [--help] ...
```
<br/>
and verify that Docker is installed by running the command:
<br/>

`docker`
<br/>
<br/>
which should return output akin to:
```
Usage:	docker [OPTIONS] COMMAND

A self-sufficient runtime for containers
```
<br/>
If either command returns an error stating the command is not found, you may install both or either of these dependecies with the commands below:

*For Ubuntu 166.04LTS+:*
```
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install git docker-ce docker-ce-cli containerd.io

```
<br/>

*For MacOS:*
```
# First install Homebrew package manager if not already installed

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Now install Git and Docker via Homebrew
brew install git
brew install docker
```
<br/>
Verify <em>both</em> these dependencies are installed via the commands listed above before continuing.

Now that all required dependencies have been installed, go the directory where you would prefer to store the test repository and run the following command:

```
git clone https://github.com/scorbettUM/zebra-tests.git
```

Once the repository is successfully cloned, navigate to the main directory via:

```
cd zebra-tests
```

and run the tests via the command:

```
./scripts/run-tests.sh --variable ZEBRA_URL:"https://www.thezebra.com"  tests/
```

<em>Note:</em> - If you receive a runtime permisions error when attempting to run the script (particularly on Ubuntu), run the below command to make the script executable, and then try the above command again:

```
chmod +x ./scripts/run-tests.sh
```
Newer versions of Ubuntu seem particularly strict about script execution permissions.

<br/>

#### *Advanced Usage*
As simple as the tools and code for the tests are, there are a few nice options offered to customize test execution.

First, the tests allow for a user to specify a target site. This is useful if (for example) you want to target a staging instance of the site as opposed to the customer-facing production version. To specify the target instance url, simply copy the text below and change the text between the quotes to the url of the target instance of choice:

```
./scripts/run-tests.sh --variable ZEBRA_URL:"<TARGET_URL>"  tests/
```

Note that the:

* `ZEBRA_URL`

command-line-argument is not required to run the tests. By default, the tests will run against the live production version of the site at:

https://www.thezebra.com

The tests also allow you to specify subdirectories of tests to execute. For example, if I wanted to only execute the functional tests, I could adapt our basic test-run command as follows:

```
./scripts/run-tests.sh --variable ZEBRA_URL:"https://www.thezebra.com"  tests/functional/ui
```

Likewise, if I only need to run the scenario tests, I may do so via the command:

```
./scripts/run-tests.sh --variable ZEBRA_URL:"https://www.thezebra.com"  tests/scenario/ui
```

Note Robot will execute <em>all</em> tests specified within a given subdirectory, including tests in subdirectories of the path specified. For the current tests, I recommend only specifying execution as far as the innermost subdirectory. Tests provided currently rely on:

* `__init__.robot`

within those respective directories to perform critical test setup at the suite (directory) level while minimizing repetition of said setup.

There are several additional environmental variables that may be configure via the:

```
--variables
```

argument, however the:

`CLICK_SLEEP`

argument is likely the one testers may find useful in navigating troublesome and often non-deterministic UI race conditions. You may adjust this variable as below:

```
./scripts/run-tests.sh --variable ZEBRA_URL:"https://www.thezebra.com" --variable CLICK_SLEEP:<SECONDS_SLEEP>  tests/scenario/ui
```

Where:

`<SECONDS_SLEEP>`

is a whole integer.

As modern UIs often contain a good amount of visual wizardry, simply mechanistically and rapidly clicking through form options can often lead to errors due to Selenium attempting to interact with the UI faster than required UI elements are availible for input. Whether this is the fault of Selenium or increasing complexity is UI design is a debate for another day, however introducing a small degree of latency between rapid UI interactions (a few seconds or more on resource-constrained systems) is often a good method of dealing with these inevitable race conditions.

The tradeoff is of course that as the number of automated interactions increases, the more the small amount of latency compounds, resulting in complex UI navigation for full integrated test suites sometimes taking several minutes when they could (and some argue should) take merely a few seconds. I personally feel this is fine an acceptable, even in keeping with the spirit of integrated UI tests simulating human behavior. As humans rarely work through a form in a matter of a few seconds, so too should our tests attempt to replicate that pacing.

<br/>

#### Logging
