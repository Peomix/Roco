package com.QQ.angel.extensions
{
   import com.QQ.angel.api.plug.extension.IExtension;
   import flash.text.TextField;
   
   public interface IChatExtension extends IExtension
   {
      
      function init(param1:TextField) : void;
      
      function acceptWords(param1:String) : Boolean;
   }
}

