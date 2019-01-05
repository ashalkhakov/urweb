import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('Cselect/main')

        # initial state
        self.assertEqual('Wilbur', self.xpath('p/span').text)

        s = self.xpath('select')

        opts = s.find_elements_by_tag_name('option')

        # click on an option
        opts[1].click()
        alert = self.driver.switch_to.alert
        self.assertEqual("Now it's Walbur", alert.text)
        alert.accept()
        self.assertEqual('Walbur', self.xpath('p/span').text)

        # and another click
        opts[0].click()
        alert = self.driver.switch_to.alert
        self.assertEqual("Now it's Wilbur", alert.text)
        alert.accept()
        self.assertEqual('Wilbur', self.xpath('p/span').text)
