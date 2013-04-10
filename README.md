# What is it?

has_setting is a simple extension that enables ActiveRecord models to
store settings in a separate settings table as key/value pairs where the key and value are stored as strings.


# Installation

Add has_setting to your gemfile:

    gem 'has_setting'

# Setup

 * Add a migration that looks more or less like the one in <em>help/001_create_settings.rb</em>
 * Make sure the gem is loaded when your application starts

# Config

The model you want to hold settings (i.e. User, Profile, ...):

    has_setting(:name_of_the_setting)

This will create the following methods for you on the owner class:
 * `name_of_the_setting=(value)` a standard setter
 * `name_of_the_setting()` a standard getter (the getter method takes an optional hash to override some options, possible values are the same as the options in has_setting())
 
`has_setting(name, options)` takes an optional hash of options. Following options are supported:

*:type* allows you to convert the value:

  * *:string* (default) Uses the StringFormatter to convert from/to String (actually this formatter just leaves the value as it is)
  * *:int* Uses the IntFormatter to convert from/to int values.
  * *:boolean* Uses the BooleanFormatter to convert from/to boolean values; treating 0, '0', false, '' and nil as false.
  * *:strict_boolean* Uses the StrictBooleanFormatter to convert from/to boolean values; treating false, and nil as false.
  * *:float* Uses the FloatFormatter to convert from/to float values.
  * *:ints* Uses the IntsFormatter to convert from/to int[]
  * *:floats* Uses the FloatsFormatter to convert from/to float[]
  * *:strings* Uses the StringsFormatter to convert from/to string[]
  * *:booleans* Uses the BooleansFormatter to convert from/to boolean[]
  * *:strict_booleans* Uses the BooleansFormatter to convert from/to boolean[]
  * *:default* allows you to specify a default value that will be returned if the setting does not exist (i.e. has never been written). Note that the default value is _ignored_ if the setting exists, no matter what the value of the setting is. The default value is returned as is, no type conversion takes place.



# How it works

A polymorphic parent-child relation is created between Setting and the parent/owning class.
Getters/setters are added through meta-programming-magic. If the setter is invoked on a unsafed parent then the setting is not saved until the parent is saved, else setting is saved upon creation (i.e. first time the setter is called) / change (subsequent calls).
The getters/setters can be used in standard AR validations, Rails mass assignments/form helpers and so on.


# Locale Awareness

has_setting has basic locale awareness. So when getting a setting, has_setting looks for the setting with the current locale. If it doesn't find it, it just grabs the first setting it finds, ignoring the locale.
When setting a setting, has_setting will look if a setting exists with the current locale and if not create a new settings record for the current locale.


# Gotchas

 * Values are stored as Strings in the DB. Values are converted with one of the formatters (depending on selected :type). If you try to store an unsupported type or anything other than the type you selected there might be an exception (i.e. if you try to store "foobar" as an :type => :int)
 * Currently there are no length validations on the 'name' and 'value' column of Setting. Take care not to store values to big. Especially when using the array formatters (:floats, :ints, :strings)
 
 
# Example

```
class Foo < ActiveRecord::Base
  has_setting(:string_setting)
  has_setting(:another_string_setting, :type => :string)
  has_setting(:int_setting, :type => :int)
  has_setting(:float_setting, :type => :float, :default => 3.3)
end


foo = Foo.create

foo.string_setting
=> nil
foo.string_setting= 'a string'
foo.string_setting
=> 'a string'

foo.int_setting = 123
foo.int_setting
=> 123
foo.int_setting = '123'
foo.int_setting
=> 123

foo.float_setting
=> 3.3
foo.float_setting = nil
foo.float_setting
=> nil
```

   
# Todo

has_setting should stay as simple as possible... still some ideas are around:
 * Custom formatter (to convert arbitrary objects, i.e. Date/Time/DateTime...)
 * Add validation options

# History

 * 0.5:
   * Added basic locale awareness. If you update from a previous version, you need to add a locale column to the settings table.
 * 0.4.3:
   * Changed behaviour of :boolean formatters: Now they treat '0', 0, false, nil and '' as false, everything else as true
     This is not the same behaviour as ruby (treating only nil and false as false) but should help with input from web forms (i.e. checkboxes)
     If you want strict ruby boolean behaviour, then use :strict_boolean as :type
 * 0.4.2:
   * bug fixes for boolean types default values
 * 0.3.10:
   * added boolean and booleans formatters
 * 0.3.9:
   * added type :strings, :floats, :ints. They store the contents of an array as a comma separated string. 
 * 0.3.8:
   * added dependent destroy option. no more zombie settings lingering around.
 * 0.3.7: 
   * Gem is now built using jeweler... after messing around and bumping versions and getting 
     strange errors, this is 'it works' feeling coming back
 * 0.3.4: 
   * Added custom formatter support. no new formatters though...
 * 0.3.1: 
   * Bug Fixed: has_many(:settings) is not added to ActiveRecord::Base but only to the classes with has_setting
   * Bug Fixed: options are not shared between classes
   * Again changed the way settings are saved. Save is now done on parent.save with an after_save callback. (like this the settings are treated as if they were attributes of the owner)
 * 0.2.x: 
   * Added :default option
   * changed way settings are saved so that unsaved parents can have settings too
   * changed nameing scheme of setting names (incompatible with versions prior 0.2.x but since nobody uses the gem i dont care :-))
 * 0.1.x: First Version

