#--
# Copyright (c) 2004 David Heinemeier Hansson

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# Engine Hacks by James Adam, 2005.
#++

module ::Dependencies
  
  alias :rails_official_require_or_load :require_or_load
  def require_or_load(file_name)
    file_name = $1 if file_name =~ /^(.*)\.rb$/
    
    # try and load the engine code first
    # can't use model, as there's nothing in the name to indicate that the file is a 'model' file
    # rather than a library or anything else.
    ['controller', 'helper'].each do |type| 
      # if we recognise this type
      if file_name.include?('_' + type)
 
        # ... go through the active engines from last started to first
        Engines.each_in_load_order do |engine|
 
          engine_file_name = File.join(engine.root, 'app', "#{type}s",  File.basename(file_name))
          engine_file_name = $1 if engine_file_name =~ /^(.*)\.rb$/
 
          if File.exist?("#{engine_file_name}.rb")
 
            begin
              loaded << engine_file_name
              if load?
                if !warnings_on_first_load or history.include?(file_name)
                  load "#{engine_file_name}.rb"
                else
                  enable_warnings { load "#{engine_file_name}.rb" }
                end
              else
                require engine_file_name
              end
            rescue
              # couldn't load the engine file
              loaded.delete engine_file_name
              raise
            end
            
            history << engine_file_name
          end
        end
      end 
    end
    
    # finally, load any application-specific controller classes using the 'proper'
    # rails load mechanism
    rails_official_require_or_load(file_name)
  end

# See Ticket #79
#   class RootLoadingModule < LoadingModule
#     # hack to allow adding to the load paths within the Rails Dependencies mechanism.
#     # this allows Engine classes to be unloaded and loaded along with standard
#     # Rails application classes.
#     def add_path(path)
#       @load_paths << (path.kind_of?(ConstantLoadPath) ? path : ConstantLoadPath.new(path))
#     end
#   end
end