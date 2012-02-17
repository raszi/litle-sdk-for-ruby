=begin
Copyright (c) 2012 Litle & Co.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
=end
require 'lib/LitleOnline'
require 'test/unit'

class Test_echeckVerification < Test::Unit::TestCase

  def test_simple_echeckVerification
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'amount'=>'123456',
      'orderId'=>'12345',
      'orderSource'=>'ecommerce',
      'echeck' => {'accType'=>'Checking','accNum'=>'12345657890','routingNum'=>'123456789','checkNum'=>'123455'},
      'billToAddress'=>{'name'=>'Bob','city'=>'lowell','state'=>'MA','email'=>'litle.com'}
    }
    response= LitleOnlineRequest.new.echeckVerification(hash)
    assert_equal('Valid Format', response.message)
  end

  def test_echeckVerification_withechecktoken
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'amount'=>'123456',
      'orderId'=>'12345',
      'orderSource'=>'ecommerce',
      'echeckToken' => {'accType'=>'Checking','litleToken'=>'1234565789012','routingNum'=>'123456789','checkNum'=>'123455'},
      'billToAddress'=>{'name'=>'Bob','city'=>'lowell','state'=>'MA','email'=>'litle.com'}
    }
    response= LitleOnlineRequest.new.echeckVerification(hash)
    assert_equal('Valid Format', response.message)
  end

  def test_extrafieldand_incorrectOrder
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'amount'=>'123',
      'invalidfield'=>'nonexistant',
      'echeck' => {'accType'=>'Checking','accNum'=>'12345657890','routingNum'=>'123456789','checkNum'=>'123455'},
      'orderId'=>'12345',
      'orderSource'=>'ecommerce',
      'billToAddress'=>{'name'=>'Bob','city'=>'lowell','state'=>'MA','email'=>'litle.com'}
    }
    response= LitleOnlineRequest.new.echeckVerification(hash)
    assert_equal('Valid Format', response.message)
  end

  def test_extrafieldand_missingBilling
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'amount'=>'123',
      'invalidfield'=>'nonexistant',
      'echeck' => {'accType'=>'Checking','accNum'=>'12345657890','routingNum'=>'123456789','checkNum'=>'123455'},
      'orderId'=>'12345',
      'orderSource'=>'ecommerce',
    }
    response= LitleOnlineRequest.new.echeckVerification(hash)
    assert(response.message =~ /Error validating xml data against the schema/)
  end

end
