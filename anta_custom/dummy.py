"""
Test functions related to system-level features and protocols
"""
from typing import Optional

from anta.models import AntaCommand, AntaTest


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
