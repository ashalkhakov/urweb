import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('main')
        d1 = self.xpath('div[1]')
        self.assertEqual("style2 style1", d1.get_attribute("class"))

        d2 = self.xpath('div[2]')
        self.assertEqual("style2", d2.get_attribute("class"))

        d3 = self.xpath('div[3]')
        self.assertEqual("", d3.get_attribute("class"))
        self.assertEqual("small-caps", d3.value_of_css_property("font-variant"))
        # NOTE: 700 means "bold"!
        self.assertEqual("700", d3.value_of_css_property("font-weight"))

        d4 = self.xpath('div[4]')
        self.assertEqual("", d4.get_attribute("class"))
        self.assertEqual("small-caps", d4.value_of_css_property("font-variant"))
