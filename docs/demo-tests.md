# Build your ANTA test step by step

A custom library is provided part of this repository under `anta_custom` folder. All your tests should be created here in this demo context.

In this demo, we are going to recreate an existing tests (`VerifyUptime`) in our own library using [`anta_custom/dummy.py`](../anta_custom/dummy.py) file.

## Python imports

### Mandatory imports

The following elements have to be imported:

- [anta.models.AntaTest](https://www.anta.ninja/v0.7.2/api/models/#anta.models.AntaTest): class that gives you all the tooling for your test
- [anta.models.AntaCommand](https://www.anta.ninja/v0.7.2/api/models/#anta.models.AntaCommand): A class to abstract an Arista EOS command

```python
from anta.models import AntaTest, AntaCommand


class VerifyUptime(AntaTest):
    """
    This test verifies if the device uptime is higher than the provided minimum uptime value.

    Expected Results:
      * success: The test will pass if the device uptime is higher than the provided value.
      * failure: The test will fail if the device uptime is lower than the provided value.
      * skipped: The test will be skipped if the provided uptime value is invalid or negative.
    """
    ...

    @AntaTest.anta_test
    def test(self) -> None:
        pass
```

## Code for a test

A test is a python class where a test function is defined and will be run by the framework. So first you need to declare your class and then define your test function.

### Create Test Class

To create class, you have to provide 4 elements:

__Metadata information__

- `name`: Name of the test
- `description`: A human readable description of your test
- `categories`: a list of categories to sort test.

__Commands to run__

- `commands`: a list of command to run. This list _must_ be a list of `AntaCommand` which is described in the next part of this document.
- `template`: a command template (`AntaTemplate`) to run where variables are provided during test execution.

```python
from __future__ import annotations

import logging
from typing import Any, Dict, List, Optional, cast

from anta.models import AntaTest, AntaCommand


class VerifyUptime(AntaTest):
    """
    This test verifies if the device uptime is higher than the provided minimum uptime value.

    Expected Results:
      * success: The test will pass if the device uptime is higher than the provided value.
      * failure: The test will fail if the device uptime is lower than the provided value.
      * skipped: The test will be skipped if the provided uptime value is invalid or negative.
    """

    name = "VerifyUptime"
    description = "My Custom Test."
    categories = ["custom_system"]
    commands = [AntaCommand(command="show uptime")]
```

### Function definition

The code here can be very simple as well as very complex and will depend of what you expect to do. But in all situation, the same baseline can be leverage:

```python
class VerifyUptime(AntaTest):
    ...
    @AntaTest.anta_test
    def test(self, minimum: Optional[int] = None) -> None:
        pass
```

The options __must__ be optional keyword arguments: `minimum: Optional[int] = None`

### Check inputs

If your test has some user inputs, you first have to validate the supplied values are valid. If it is not valid, we expect `TestResult` to return `skipped` with a custom message.

```python
class VerifyUptime(AntaTest):
    ...
    @AntaTest.anta_test
    def test(self, minimum: Optional[int] = None) -> None:
        # Check if test option is correct
        if not (isinstance(minimum, (int, float))) or minimum < 0:
            self.result.is_skipped(
                f"{self.__class__.name} was not run since the provided uptime value is invalid or negative"
            )
            return
        # continue test..
        ...
```

### Implement your logic

Here you implement your own logic. In general, the first action is to send command to devices and capture its response.

In the example below, we request the list of vlans configured on device and then count all the vlans marked as dynamic

```python
class VerifyUptime(AntaTest):
    ...
    @AntaTest.anta_test
    def test(self, minimum: Optional[int] = None) -> None:
        """
        Run VerifyUptime validation

        Args:
            minimum: Minimum uptime in seconds.
        """

        command_output = self.instance_commands[0].json_output

        if not (isinstance(minimum, (int, float))) or minimum < 0:
            self.result.is_skipped(f"{self.__class__.name} was not run since the provided uptime value is invalid or negative")
            return

        if command_output["upTime"] > minimum:
            self.result.is_success()
        else:
            self.result.is_failure(f"Device uptime is {command_output['upTime']} seconds")
```

## Create your catalog

Our custom library is `anta_custom` and the test is configured in `anta_custom.dummy`, the test catalog would look like:

```yaml
anta_custom.dummy:
  - VerifyUptime:
      minimum: 1
```

## Start topology and run tests

* Download cEOS in version 4.28.3M

```bash
ardl get eos --version 4.28.3M --image-type cEOS --import-docker
```

* Start initial topology

```bash
cd containerlab-topology
sudo containerlab deploy --topo topology.yml --reconfigure
cd ..
```

* And now you can run your NRFU tests with the CLI:

```bash
$ source anta.env
Creating default anta variables
Build auto-complete for anta

$ anta nrfu -c network-tests/nrfu_custom.yml table
╭────────────────────── Settings ──────────────────────╮
│ Running ANTA tests:                                  │
│ - ANTA Inventory contains 5 devices (AsyncEOSDevice) │
│ - Tests catalog contains 1 tests                     │
╰──────────────────────────────────────────────────────╯

[11:31:19] INFO     Running ANTA

                                   All tests results
┏━━━━━━━━━┳━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┓
┃ Device  ┃ Test Name    ┃ Test Status ┃ Message(s) ┃ Test description ┃ Test category ┃
┡━━━━━━━━━╇━━━━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━┩
│ spine01 │ VerifyUptime │ success     │            │ My Custom Test.  │ custom_system │
│ spine02 │ VerifyUptime │ success     │            │ My Custom Test.  │ custom_system │
│ leaf01  │ VerifyUptime │ success     │            │ My Custom Test.  │ custom_system │
│ leaf02  │ VerifyUptime │ success     │            │ My Custom Test.  │ custom_system │
│ leaf03  │ VerifyUptime │ success     │            │ My Custom Test.  │ custom_system │
└─────────┴──────────────┴─────────────┴────────────┴──────────────────┴───────────────┘
```

## What next ?

You can find more information on [anta website](https://anta.ninja) about how to [build your custom library](https://www.anta.ninja/v0.7.2/advanced_usages/custom-tests/).