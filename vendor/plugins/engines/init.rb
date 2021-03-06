#--
# Copyright (c) 2005 James Adam
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++


require 'engines'

#--
# Create the Engines directory if it isn't present
#++
if !File.exist?(Engines.config(:root))
  RAILS_DEFAULT_LOGGER.debug "Creating engines directory in /vendor"
  FileUtils.mkdir_p(Engines.config(:root))
end

# Output a message to let folks know that this version is going to retire soon.
RAILS_DEFAULT_LOGGER.warn <<EOS
This version of the Rails Engines plugin will soon be made obsolete, as main
development for Edge Rails proceeds in the trunk of this repository:

  http://opensvn.csie.org/rails_engines/engines/trunk
  
An announcement will be made on the Engines mailing list when this happens.
For more information, please go to the Rails Engines site:

  http://rails-engines.org
  
EOS