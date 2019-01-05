import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start()
        el = self.xpath('input')

        el.click()
        alert = self.driver.switch_to.alert
        self.assertRegex(alert.text, "^Clicky .*$")
        alert.accept()

        el.send_keys('A')
        alert = self.driver.switch_to.alert
        self.assertEqual("Code 65", alert.text)
        alert.accept()
