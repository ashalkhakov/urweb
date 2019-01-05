import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('main')
        l = self.xpath('form/input[1]')
        l.click()
        s = self.xpath('form/input[2]')
        s.click()
        self.assertEqual("Yes", self.body_text())

    def test_2(self):
        """Test case 2"""
        self.start('main')
        s = self.xpath('form/input[2]')
        s.click()
        self.assertEqual("No", self.body_text())
