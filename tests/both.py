import unittest
import base
import os

class Suite(base.Base):
    def test_2(self):
        self.start('Both/main')
        uw0 = self.xpath('form[1]/input[@type="submit"]')
        uw0.submit()
        self.assertEqual("", self.body_text())
