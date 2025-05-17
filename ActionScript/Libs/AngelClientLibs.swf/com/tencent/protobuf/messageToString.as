package com.tencent.protobuf
{
   import flash.utils.*;
   
   public function messageToString(param1:Object) : String
   {
      var getter:String = null;
      var field:String = null;
      var k:* = undefined;
      var message:Object = param1;
      var s:String = getQualifiedClassName(message) + "(\n";
      var descriptor:XML = describeType(message);
      for each(getter in descriptor.accessor.(@access != "writeonly").@name)
      {
         if(getter.search(/^has[A-Z]/) == -1)
         {
            s += fieldToString(message,descriptor,getter);
         }
      }
      for each(field in descriptor.variable.@name)
      {
         if(field.search(/^_/) == -1)
         {
            s += fieldToString(message,descriptor,field);
         }
      }
      for(k in message)
      {
         s += k + "=" + message[k] + ";\n";
      }
      s += ")";
      return s;
   }
}

function fieldToString(param1:Object, param2:XML, param3:String):String
{
   var field:*;
   var message:Object = param1;
   var descriptor:XML = param2;
   var name:String = param3;
   var hasField:String = "has" + name.charAt(0).toUpperCase() + name.substr(1);
   if(descriptor.accessor.(@name == hasField).length() != 0 && !message[hasField])
   {
      return "";
   }
   field = message[name];
   if(field != null && !(field is Message || field is ExtensibleMessage) && field is Array && field.length == 0)
   {
      return "";
   }
   return name + "=" + field + ";\n";
}
