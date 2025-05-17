package com.QQ.angel.install.loader
{
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class RetrySecretLoaderCutFile extends RetrySecretLoader
   {
      
      private var noCacheMode:Boolean = false;
      
      private var cutFileNum:int;
      
      private var cutFileName:String;
      
      private var destByte:ByteArray = new ByteArray();
      
      private var __currTryTimesDecode:int;
      
      private var currentFileId:int;
      
      private var cutFileLoaderContext:LoaderContext;
      
      private var version:String;
      
      private var cutFileMode:Boolean;
      
      private var bufferByte:ByteArray = new ByteArray();
      
      private var cutFileBytes:uint;
      
      public function RetrySecretLoaderCutFile()
      {
         super();
      }
      
      override protected function onStreamProgress(param1:ProgressEvent) : void
      {
         var _loc2_:String = null;
         if(cutFileMode)
         {
            if(param1.bytesLoaded < 5)
            {
               return;
            }
            if(currentFileId == 0 && cutFileNum == -1)
            {
               _loc2_ = stream.endian;
               stream.endian = Endian.LITTLE_ENDIAN;
               cutFileBytes = stream.readUnsignedInt();
               stream.endian = _loc2_;
               cutFileNum = stream.readByte();
            }
            param1.bytesTotal = cutFileBytes + 5;
            param1.bytesLoaded += destByte.length + (currentFileId == 0 ? 0 : 5);
         }
         super.onStreamProgress(param1);
      }
      
      override protected function onStreamComplete(param1:Event) : void
      {
         if(!cutFileMode)
         {
            super.onStreamComplete(param1);
         }
         else
         {
            bufferByte.position = 0;
            bufferByte.length = 0;
            stream.readBytes(bufferByte);
            destByte.writeBytes(bufferByte);
            ++currentFileId;
            if(currentFileId == cutFileNum)
            {
               currBytes.length = 0;
               destByte.position = 0;
               destByte.readBytes(currBytes);
               destByte.length = 0;
               __loadState = RetryLoader.LOADER;
               __url = cutFileName + ".part" + 0 + version;
               currentFileId = 0;
               if(currentFileId == 0)
               {
                  noCacheMode = true;
                  ++__currTryTimesDecode;
                  bufferByte.length = 0;
                  destByte.length = 0;
                  cutFileNum = -1;
                  cutFileBytes = 0;
               }
               __currTryTimes = __currTryTimesDecode;
               dealCurrBytes();
            }
            else if(currentFileId < cutFileNum)
            {
               load(new URLRequest(cutFileName + ".part" + currentFileId + version),cutFileLoaderContext);
            }
         }
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:URLRequestHeader = null;
         var _loc3_:int = int(param1.url.indexOf(".part"));
         if(_loc3_ != -1)
         {
            _loc4_ = int(param1.url.indexOf("?"));
            if(_loc4_ == -1)
            {
               cutFileMode = _loc3_ >= param1.url.length - 9;
            }
            else
            {
               cutFileMode = _loc3_ >= param1.url.length - 9 - (param1.url.length - _loc4_);
            }
         }
         else
         {
            cutFileMode = false;
         }
         if(cutFileMode)
         {
            if(_loc4_ == -1)
            {
               version = "";
            }
            else
            {
               version = param1.url.substr(_loc4_);
               param1.url = param1.url.substr(0,_loc4_);
            }
            _loc5_ = cutFileName;
            cutFileName = param1.url.substr(0,_loc3_);
            _loc6_ = param1.url.substr(_loc3_ + 5);
            currentFileId = int(_loc6_);
            if(currentFileId == 0)
            {
               if(cutFileName == _loc5_)
               {
                  noCacheMode = true;
                  ++__currTryTimesDecode;
               }
               else
               {
                  noCacheMode = false;
                  __currTryTimesDecode = 0;
               }
               currBytes.length = 0;
               cutFileLoaderContext = param2;
               bufferByte.length = 0;
               destByte.length = 0;
               cutFileNum = -1;
               cutFileBytes = 0;
            }
            param1.url += version;
            if(noCacheMode)
            {
               _loc7_ = new URLRequestHeader("pragma","no-cache");
               param1.data = new URLVariables("name=angel");
               param1.method = URLRequestMethod.POST;
               param1.requestHeaders = [_loc7_];
            }
         }
         else
         {
            currentFileId = 0;
            cutFileNum = 1;
         }
         super.load(param1,param2);
      }
   }
}

