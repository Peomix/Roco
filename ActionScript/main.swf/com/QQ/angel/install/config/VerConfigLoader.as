package com.QQ.angel.install.config
{
   import com.QQ.angel.install.config.zip.ZipEntry;
   import com.QQ.angel.install.config.zip.ZipFile;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class VerConfigLoader
   {
      
      protected var _success:Function;
      
      protected var _hasTryTime:int;
      
      protected var _xml:XML;
      
      protected var _stream:URLStream;
      
      protected var _tryTime:int;
      
      protected var _name:String;
      
      protected var _byteArray:ByteArray;
      
      protected var _url:String;
      
      protected var _fail:Function;
      
      public function VerConfigLoader(param1:String = "", param2:String = "", param3:Function = null, param4:Function = null, param5:int = 1)
      {
         super();
         _stream = new URLStream();
         init(param1,param2,param3,param4,param5);
      }
      
      public function cancel() : void
      {
         try
         {
            if(_stream)
            {
               _stream.close();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         onError();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function dispose() : void
      {
         reset();
         cancel();
         _stream = null;
         _byteArray = null;
         _success = null;
         _fail = null;
      }
      
      public function reset() : void
      {
         _success = null;
         _fail = null;
         removeEvent();
         _byteArray = null;
      }
      
      public function init(param1:String = "", param2:String = "", param3:Function = null, param4:Function = null, param5:int = 1) : void
      {
         _url = param1;
         _name = param2;
         _success = param3;
         _fail = param4;
         _tryTime = param5;
         _hasTryTime = 0;
      }
      
      private function completeHandler(param1:Event) : void
      {
         _byteArray = new ByteArray();
         _stream.readBytes(_byteArray,0,_stream.bytesAvailable);
         if(decode() == true)
         {
            onSuccess();
         }
         else
         {
            onError();
         }
      }
      
      public function get xml() : XML
      {
         return _xml;
      }
      
      public function load() : void
      {
         ++_hasTryTime;
         removeEvent();
         addEvent();
         _stream.load(new URLRequest(_url));
         trace("正在加载：" + _url);
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         onError();
      }
      
      protected function onSuccess() : void
      {
         if(_success != null)
         {
            _success && _success.length == 1 && _success(this);
            _success && _success.length == 0 && _success();
         }
      }
      
      protected function decode() : Boolean
      {
         var zip:ZipFile = null;
         var entry:ZipEntry = null;
         var bytes:ByteArray = null;
         var value:String = null;
         if(Boolean(_byteArray) && _byteArray.length > 0)
         {
            _byteArray.endian = Endian.LITTLE_ENDIAN;
            _byteArray.position = 0;
            try
            {
               zip = new ZipFile(_byteArray);
               entry = zip.getEntry("ver.xml");
               bytes = zip.getInput(entry);
               value = bytes.readUTFBytes(bytes.length);
               value = value.toLocaleLowerCase();
               _xml = new XML(value);
               return true;
            }
            catch(e:Error)
            {
               trace("解压ver.config异常:" + e.toString());
               return false;
            }
         }
         else
         {
            return false;
         }
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      private function removeEvent() : void
      {
         if(_stream)
         {
            _stream.removeEventListener(Event.COMPLETE,completeHandler);
            _stream.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            _stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         }
      }
      
      protected function onError() : void
      {
         if(_hasTryTime >= _tryTime)
         {
            _fail && _fail.length == 1 && _fail(this);
            _fail && _fail.length == 0 && _fail();
         }
         else
         {
            load();
         }
      }
      
      private function addEvent() : void
      {
         if(_stream)
         {
            _stream.addEventListener(Event.COMPLETE,completeHandler);
            _stream.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            _stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         }
      }
   }
}

