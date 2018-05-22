import unittest
import base
import os

class Suite(base.Base):
    def count_list(self):
        l = self.xpath('ul')
        items = l.find_elements_by_tag_name('li')
        c = 0
        for item in items:
            c = c + 1
        return c
    def test_1(self):
        # empty submit works
        self.start('BlobOpt/main')
        c0 = self.count_list()
        uw0 = self.xpath('form[2]/input')
        uw0.submit()
        c1 = self.count_list()
        self.assertEqual(c0 + 1, c1)
        # navigate to last link in list & ensure it reads "This one's empty."
        self.start('BlobOpt/viewPage/' + str(c1))
        self.assertEqual("This one's empty.", self.body_text())
    def test_2(self):
        # non-empty submit works as well
        self.start('BlobOpt/main')
        c0 = self.count_list()        
        uw0 = self.xpath('form[1]/input')
        uw1 = self.xpath('form[1]/input[@name="Data"]')
        mypath = os.path.dirname(os.path.abspath(__file__)) + '/blobOpt.txt'
        uw1.send_keys(mypath)
        uw0.submit()
        c1 = self.count_list()
        self.assertEqual(c0 + 1, c1)
        # and you can actually get the latest file & view it
        self.start('BlobOpt/viewPage/' + str(c1))
        with open(mypath, 'r') as myfile:
            data = myfile.read().strip()
        self.assertEqual(data, self.body_text())
