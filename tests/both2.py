import unittest
import base
import os

class Suite(base.Base):
    def test_2(self):
        self.start('Both2/main')
        uw0 = self.xpath('form[1]/input[@type="submit"]')
        uw1 = self.xpath('form[1]/input[@type="text"]')
        text = "HELLO THERE"
        uw1.send_keys(text)
        uw0.submit()
        self.assertEqual(text, self.body_text())
