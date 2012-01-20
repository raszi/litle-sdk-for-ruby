=begin
Copyright (c) 20011 Litle & Co.

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

require_relative '../lib/LitleOnline'
require_relative '../lib/LitleOnlineRequest'
require 'test/unit'

 class Test_echeckCredit < Test::Unit::TestCase
	 def test_simple_echeckcredit
		 hash = {
		 'merchantId' => '101',
		 'user' => 'PHXMLTEST',
		 'password'=> 'certpass',
		 'version'=>'8.8',
		 'reportGroup'=>'Planets',
		 'litleTxnId'=>'123456789101112',
		 'amount'=>'12'
		 }
		 response= LitleOnlineRequest.echeckCredit(hash)
		 assert_equal('Valid Format', response.message)
	 end
	 def test_noReportGroup
		 hash = {
		 'merchantId' => '101',
		 'user' => 'PHXMLTEST',
		 'password'=> 'certpass',
		 'version'=>'8.8',
		 'litleTxnId'=>'123456',
		}
		 exception = assert_raise(RuntimeError){LitleOnlineRequest.echeckCredit(hash)}
   		 assert_match /Missing Required Field: @reportGroup!!!!/, exception.message
        end
	def test_noAmount
		 hash = {
		 'merchantId' => '101',
		 'user' => 'PHXMLTEST',
		 'password'=> 'certpass',
		 'version'=>'8.8',
		 'reportGroup'=>'Planets',
		}
		 exception = assert_raise(RuntimeError){LitleOnlineRequest.echeckCredit(hash)}
   		 assert_match /Missing Required Field: amount!!!!/, exception.message
        end
	def test_echeckCredit_withecheck
		 hash = {
		 'merchantId' => '101',
		 'user' => 'PHXMLTEST',
		 'password'=> 'certpass',
		 'version'=>'8.8',
		 'reportGroup'=>'Planets',
		 'amount'=>'123456',
		 'verify'=>'true',
		 'orderId'=>'12345',
		 'orderSource'=>'ecommerce',
		 'echeck' => {'accType'=>'Checking','accNum'=>'12345657890','routingNum'=>'123456789','checkNum'=>'123455'},
		 'billToAddress'=>{'name'=>'Bob','city'=>'lowell','state'=>'MA','email'=>'litle.com'}
		 }
		 response= LitleOnlineRequest.echeckCredit(hash)
		 assert_equal('Valid Format', response.message)
	end
	def test_echeckCredit_withechecktoken
		 hash = {
		 'merchantId' => '101',
		 'user' => 'PHXMLTEST',
		 'password'=> 'certpass',
		 'version'=>'8.8',
		 'reportGroup'=>'Planets',
		 'amount'=>'123456',
		 'verify'=>'true',
		 'orderId'=>'12345',
		 'orderSource'=>'ecommerce',
		 'echeckToken' => {'accType'=>'Checking','litleToken'=>'1234565789012','routingNum'=>'123456789','checkNum'=>'123455'},
		 'billToAddress'=>{'name'=>'Bob','city'=>'lowell','state'=>'MA','email'=>'litle.com'}
		 }
		 response= LitleOnlineRequest.echeckCredit(hash)
		 assert_equal('Valid Format', response.message)
	end
	def test_echeckCredit_withBOTH
		 hash = {
		 'merchantId' => '101',
		 'user' => 'PHXMLTEST',
		 'password'=> 'certpass',
		 'version'=>'8.8',
		 'reportGroup'=>'Planets',
		 'litleTxnId'=>'123456',
		 'echeckToken' => {'accType'=>'Checking','litleToken'=>'1234565789012','routingNum'=>'123456789','checkNum'=>'123455'},
		 'echeck' => {'accType'=>'Checking','accNum'=>'12345657890','routingNum'=>'123456789','checkNum'=>'123455'}
		 }
		exception = assert_raise(RuntimeError){LitleOnlineRequest.echeckCredit(hash)}
   		assert_match /Entered an Invalid Amount of Choices for a Field, please only fill out one Choice!!!!/, exception.message
	end
	def test_extrafieldand_incorrectOrder
		 hash = {
		 'merchantId' => '101',
		 'user' => 'PHXMLTEST',
		 'password'=> 'certpass',
		 'version'=>'8.8',
		 'reportGroup'=>'Planets',
		 'amount'=>'123',
		 'invalidfield'=>'nonexistant',
		 'echeck' => {'accType'=>'Checking','accNum'=>'12345657890','routingNum'=>'123456789','checkNum'=>'123455'},
		 'verify'=>'true',
		 'orderId'=>'12345',
		 'orderSource'=>'ecommerce',
		 'billToAddress'=>{'name'=>'Bob','city'=>'lowell','state'=>'MA','email'=>'litle.com'}
		 }
		 response= LitleOnlineRequest.echeckCredit(hash)
		 assert_equal('Valid Format', response.message)
	end
	def test_extrafieldand_missingBilling
		 hash = {
		 'merchantId' => '101',
		 'user' => 'PHXMLTEST',
		 'password'=> 'certpass',
		 'version'=>'8.8',
		 'reportGroup'=>'Planets',
		 'amount'=>'123',
		 'invalidfield'=>'nonexistant',
		 'echeck' => {'accType'=>'Checking','accNum'=>'12345657890','routingNum'=>'123456789','checkNum'=>'123455'},
		 'verify'=>'true',
		 'orderId'=>'12345',
		 'orderSource'=>'ecommerce',
		 }
		 response= LitleOnlineRequest.echeckCredit(hash)
		 assert(response.message =~ /Error validating xml data against the schema/)
	end
end

 
