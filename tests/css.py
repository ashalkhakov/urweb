import unittest
import base

class Suite(base.Base):
    def xpcls(self, n):
        return self.xpath('span[' + str(n) + ']').get_attribute("class")
    def xpst(self, n):
        return self.xpath('span[' + str(n) + ']').get_attribute("style")
    def eq(self, a, b):
        self.assertEqual(a, b)
    def test_1(self):
        """Test case 1"""
        self.start('Css/main')

        self.eq("Css_st1 Css_st2", self.xpcls(1))
        self.eq("Css_st_3 Css_st2", self.xpcls(2))
        self.eq("Css_st1", self.xpcls(3))
        self.eq("", self.xpcls(4))

        self.eq("width: 30%;", self.xpst(5))
        self.eq("Css_st_3", self.xpcls(6))
        self.eq("color: blue;", self.xpst(6)) # "red" is ignored by the browser
        self.eq('background: url("http://www.google.com/image.png");', self.xpst(7))
        self.eq('background: url("http://www.google.com/image.png") 10% 66px red;', self.xpst(8)) # order normalized by browser
        self.eq('color: red; background: url("http://www.google.com/foo.jpg");', self.xpst(9)) # wrong 'width' spec ignored by browser
