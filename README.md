# The Zebra: Robot Framework Integrated Tests
<br/>


## Overview
This repository contains the code and resources for running integrated tests for TheZebra.com via the open-source Robot Framework. The suite offers both functional and scenario UI testing as well as a suite of Robot keywords for developing additional Robot/Selenium based UI tests.
____


## Usage

#### *Requirements*
To maximize portability, the test environment and runtime have been containerized. Thus, the only requirements to run this test suite are as follows

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
If either of the above commands returns an error stating the command is not found, you may install both or either of these dependecies with the commands below:

*For Ubuntu 16.04LTS+:*
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
./scripts/run-tests.sh
```

<em>Note:</em> - If you receive a runtime permissions error when attempting to run the script (particularly on Ubuntu), run the below command to make the script executable, and then try the above command again:

```
chmod +x ./scripts/run-tests.sh
```
Newer versions of Ubuntu seem particularly strict about script execution permissions.

<br/>

#### *Advanced Usage*
As simple as the tools and code for the tests are, there are a few nice options offered to customize test execution.

First, the tests allow for a user to specify a target site. This is useful if (for example) you want to target a staging instance of the site as opposed to the customer-facing production version. To specify the target instance url, simply copy the text below and change the text between the quotes to the url of the target instance of choice:

```
./scripts/run-tests.sh --variable ZEBRA_URL:"<TARGET_URL>"
```

Note that the:

* `ZEBRA_URL`

command-line-argument is not required to run the tests. By default, the tests will run against the live production version of the site at:

https://www.thezebra.com

The tests also allow you to specify subdirectories of tests to execute. For example, if I wanted to only execute the functional tests, I could adapt our basic test-run command as follows:

```
./scripts/run-tests.sh  tests/functional/ui
```

Likewise, if I only need to run the scenario tests, I may do so via the command:

```
./scripts/run-tests.sh  tests/scenario/ui
```

Note Robot will execute <em>all</em> tests specified within a given subdirectory, including tests in subdirectories of the path specified. For the current tests, I recommend only specifying execution as far as the innermost subdirectory. Tests provided currently rely on:

* `__init__.robot`

within those respective directories to perform critical test setup at the suite (directory) level while minimizing repetition of said setup.

There are several additional environmental variables that may be configured via the:

```
--variables
```

argument, however:

`CLICK_SLEEP`

is the one testers will find most useful in navigating troublesome, often non-deterministic UI race conditions. You may adjust this variable as below:

```
./scripts/run-tests.sh --variable CLICK_SLEEP:<SECONDS_SLEEP>
```

Where:

`<SECONDS_SLEEP>`

is a whole integer.

Modern UIs often contain a good amount of visual wizardry, and rapidly clicking through form options can lead to errors due to Selenium attempting to interact with the UI faster than the required UI elements are availible for input. Whether this is the fault of Selenium or increasing complexity of user interfaces is a debate for another day, however introducing a small degree of latency between UI interactions (a few seconds or more on resource-constrained systems) is a good method of dealing with potential race conditions.

The tradeoff is that as the number of automated interactions increases, the more the small amount of latency compounds. This results in integrated UI tests taking several minutes when they would otherwise take a few seconds.

<br/>

#### Logging
By default, all logging for the test suite is at:

`WARN`

and/or:

`ERROR`

level. This is primarily to keep the amount of terminal output to a minimum so users can focus on the test execution itself, and to avoid excess terminal output slowing test execution. However, should a user desire more detailed test output execution, all "technical" keywords (the base building blocks used to execute test behavior) come equipped with excellent logging available at the:

`DEBUG`

level, which can be enabled when running tests as below:

```
./scripts/run-tests.sh --log  debug
```

Providing the:

```
--log debug
```

argument results in the generation of an HTML file where Robot stores all debug-level logs for later viewing in a browser of your choice. You may find this file in the

`reports/`

folder. Robot also provides general logs (again via an HTML file viewable via browser) in the:

`log.html`

file. Test reports and output can be found in the:

`report.xml`

and:

`output.xml`

files respectively. Either of these XML documents are relatively trivial to conver to JUnit compatible XML for integration with Jenkins or other CI/CD tools.

UI testing in Robot utilizes Selenium, and one of the most important "logging" features included is the generation of screenshots taken at the exact moment a UI test fails. This is useful for identifying exactly where a UI test failed as well as what might have caused the failure, and at least partially makes up for the Robot Framework's strange omission of stacktrace-type error reporting. These screenshots are also stored in the:

`reports/`

folder for viewing at your convenience.

<br/>

## Q&A and Notes
_________________________

<b>Question:</b> Why Robot Framework? 

In my interview with Nick Mennen and Chris Wicks, we spoke about how TheZebra is looking at transitioning a previously all-manual test/QE team to utilizing more automated tools. In my work at Lucidworks, we find ourselves likewise grappling with the same issue, and Robot Framework has proved the most successful tool yet in enabling or QE testers to utilize automation.

<b>Question:</b> What advantages does Robot Framework bring?

The biggest advantage I've found in using Robot Framework is in the development and use/reuse of the framework's "Keywords" as well as the ability to write libraries in native Python, which can then likewise be utilized as Keywords without any additional translation or integration work needed. This allows developers to quickly write bespoke tools for testing complex software with minimal setup or difficulty, while allowing less-technical testers to easily understand or even write additional tests thanks to the "plain English" nature of keyword development and usage. That a tester could have no knowledge of Python or JavaScript and be capable of writing fully functional test suites is a powerful thing indeed.

This comes with a caveat though. The quality of a Robot Framework test suite is hugely dependent on the implementation of tight coding standards and thoughtful development of keywords and libraries. Lacking strong convention and control, a Robot Framework suite runs the risk of quickly devolving into a mess of one-off keywords or libraries whose names and functionality are minimally alligned. This is something me and my fellow SDETs at Lucidworks still find ourselves struggling with. How do we write tools that are sensible and accessible to all when we have such a wide array of skill levels, backgrounds, and preferences at our organization? It's a constant struggle and balancing act, and one of the simultaneously most frustrating and rewarding parts of using this tool.

<b>Question:</b>  What are the disadvantages of Robot Framework?

The Robot Framework is <em>far</em> from a perfect tool. I find myself frustrated with the framework's failure to even include the option to view test errors via a traditional Python stacktrace, that the framework will continue to execute even if it encounters a failure (meaning that for particularly large integrated test suites, a developer has to run the whole suite, encounter an error, then make changes and run the whole thing again), and there's no clear path to parallelizing test execution. Likewise, as an open source tool, while the core libraries are often of good quality, third-party libraries vary wildly in quality and consistency of implementation. Case in point, I was forced to write a simple Python "Requests" library wrapper to execute HTTP requests against Fusion due to third-party HTTP libraries either having awkward design choices or forcing us to use sessions (as opposed to simply invoking Requests on a per-call basis).


<b>Question:</b>  What's the difference between "Technical" and "Workflow" resources and keywords?

In developing with and working with Robot Framework at Lucidworks, we quickly found an advantageous approach that encouraged QE tester adoption was to designate keywords focused on more low-level functionality as "technical" resources, and then utilize these keywords in to build more accessible and friendly "workflow" keywords.

Technical resources are  designed to be as general as possible, offering functionality that focuses on general actions a user might want to do (i.e. clicking a button, inputing text, making a GET request). Technical resources also bear the important requirement of containing <em>no</em> explicit assertions. By delegating explicit assertions like:

```
should be equal as integers  ${status_code}  200
```

to Workflow resources, it becomes easier to identify where the assertion is occuring and to adjust them without affecting additional tests that may also use a technical keyword.

Workflow resources are designed to focus on specific parts of a product (for example, a suite of keywords entirely focused on actions for the homepage), and contain explicit assertions. They are the core tools used in writing the actual test cases within the test files, and often comprise of one or more Technical keywords. Workflow resources are designed to be as explicit as possible about the underlying behavior guiding their use, allowing QE testers or non-developers to clearly see how the behavior encapsulated by a Workflow keyword is accomplished and provide a level of granularity and specialization that helps reduce boilerplate code within test files.

In our use of Technical and Workflow resources, we found this dileniation helped not only promote good code development practices and make debugging easier, but enabled our QE testers to modify feature-specific testing resources to suit changes in software or additional needs without compromising test suite integrity or overwhelming them.


<b>Question:</b>  What additional work would you do if you had more time?

As is here, the tests represent a single use case, with no negative testing and a limited set of data for input that I personally verified works. Likewise, while the test environment and runtime are containerized, they have not been containerized in a way that encourages deployment via cluster resources like Kubernetes for potential load testing or other test scenarios. Given more time, I would like to remedy both these issues, as well as break out test data (variables are currently declared within each test file for ease of reading) into seperate Robot "Variables" files, and develop additional Python Libraries to introduce a degree of stochiasticity into test execution. I'd also like to explore local parallelism with Robot. Just because the framework doesn't offer a clear path for test-case parallelism doesn't mean it can't be done!

Finally, I'd like to improve upon Robot's reporting and logging with the integration of a full Helm chart including Prometheus/Grafana logging/monitoring of K8s during test execution and a real-time API/UI service to supervise test execution logging and results.


# To The Zebra team, Daria, Nick, and Chris, thanks for your time and enjoy!
