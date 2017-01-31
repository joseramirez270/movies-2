"""
Name: Jose Ramirez
Date: 2/1/2017

Description: Program to run control.rb on different training and test sets.
"""

require './control.rb'

control = Control.new()

# try different training/test sets
control.run('u1.base', 'u1.test')
control.run('u2.base', 'u2.test')
control.run('u3.base', 'u3.test')
control.run('u4.base', 'u4.test')
control.run('u5.base', 'u5.test')

# see how time changes as number of predictions increases by 10
[100, 1000, 10000].each do |x|
  control.run('u1.base', 'u1.test', x)
end
