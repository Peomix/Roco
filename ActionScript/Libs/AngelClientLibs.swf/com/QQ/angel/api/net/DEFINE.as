package com.QQ.angel.api.net
{
   import com.QQ.angel.api.utils.ByteBuffer;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class DEFINE
   {
      
      private static var verConfXML:XML;
      
      public static var IS_DEBUG:int = 0;
      
      public static var ANGEL_VERSION:String = "0.1";
      
      public static var AVATAR_VERSION:String = "0.1";
      
      public static var TIMES_VERSION:String = "20100506";
      
      public static var SPIRIT_VER:String = "0.1";
      
      public static var SPIRIT_SKILL_VER:String = "0.1";
      
      public static var TASK_VER:String = "0.1";
      
      public static var HOMESTEAD_VER:String = "0.1";
      
      public static var MAGIC_RES_ROOT:String = "";
      
      public static var SCENE_RES_ROOT:String = "";
      
      public static var ITEM_RES_ROOT:String = "";
      
      public static var TASK_RES_ROOT:String = "";
      
      public static var AVATAR_PREV_ROOT:String = "";
      
      public static var AVATAR_ROOT:String = "";
      
      public static var DAZZLE_DRESS_RES_ROOT:String = "";
      
      public static var DAZZLE_MOUNT_RES_ROOT:String = "";
      
      public static var CGI_ROOT:String = "";
      
      public static var FASTCGI_ROOT:String = "";
      
      public static var FPS_LOG:String = "";
      
      public static var PLUGIN_ROOT:String = "";
      
      public static var COMM_ROOT:String = "";
      
      public static var NPC_RES_ROOT:String = "";
      
      public static var POLICYPORT:int = 843;
      
      public static const CHARSET:String = "gb2312";
      
      public static const L_NICKNAME:int = 16;
      
      public static const L_SESSIONKEY:int = 64;
      
      public static const L_ROOMNAME:int = 16;
      
      public static var AVATAR_MIN_NUM:int = 15;
      
      public static var AVATAR_DELAY:int = 2000;
      
      public static var SET_AVATA_VISIBLE:int = 1;
      
      private static var byteBuff:ByteBuffer = new ByteBuffer();
      
      public static var PROTOCOL_VERSION:String = "";
      
      private static var versionBase:String = Math.random().toString();
      
      public function DEFINE()
      {
         super();
      }
      
      public static function addVersion(param1:String) : String
      {
         var _loc2_:String = ANGEL_VERSION;
         if(param1.indexOf("?") == -1)
         {
            param1 += "?" + _loc2_;
         }
         else
         {
            param1 += "&" + _loc2_;
         }
         return param1;
      }
      
      public static function getVersionXML() : XML
      {
         return verConfXML;
      }
      
      public static function setVersionXML(param1:XML) : void
      {
         verConfXML = param1;
         if(verConfXML)
         {
            versionBase = verConfXML.@from;
            versionBase = versionBase.replace(/\D*/g,"");
         }
      }
      
      public static function getVersionUpdateTime() : String
      {
         if(verConfXML)
         {
            return String(verConfXML.@updateTime);
         }
         return "0";
      }
      
      public static function addHttps(param1:String) : *
      {
         if(param1 == null || param1 == "")
         {
            return param1;
         }
         if(PROTOCOL_VERSION == "https")
         {
            if(param1.indexOf("http://") == 0)
            {
               param1 = param1.replace("http://","https://");
            }
         }
         return param1;
      }
      
      public static function formatFileVersion(param1:String, param2:Boolean = true) : String
      {
         var version:String;
         var tempUrl:String = null;
         var index:int = 0;
         var xmlList:XMLList = null;
         var url:String = param1;
         var isFormat:Boolean = param2;
         var rootPath:String = "res.17roco.qq.com/";
         if(url == null || url == "" || url.toLocaleLowerCase().indexOf(rootPath) == -1 || url.indexOf("fileVersion=") != -1)
         {
            return url;
         }
         if(PROTOCOL_VERSION == "https")
         {
            if(url.indexOf("http://") == 0)
            {
               url = url.replace("http://","https://");
            }
         }
         version = "";
         if(verConfXML)
         {
            tempUrl = url.toLocaleLowerCase().replace(/[\\\/]+/g,"/");
            index = int(tempUrl.indexOf(rootPath));
            if(index != -1)
            {
               tempUrl = tempUrl.slice(index + rootPath.length);
            }
            index = int(tempUrl.indexOf("?"));
            if(index != -1)
            {
               tempUrl = tempUrl.slice(0,index);
            }
            xmlList = verConfXML.file.(@path == tempUrl);
            if(xmlList.length() > 0)
            {
               version = xmlList[0].@version;
            }
         }
         if(isFormat)
         {
            url = url.replace(/[\\\/]+/g,"/");
            url = url.replace(":/r","://r");
            url = url.replace(":/R","://R");
            index = int(url.indexOf("?"));
            if(index != -1)
            {
               url = url.slice(0,index);
            }
         }
         if(IS_DEBUG)
         {
            version = Math.random().toString();
         }
         url += url.indexOf("?") == -1 ? "?" : "&";
         url += "fileVersion=" + versionBase + (version == "" ? "" : "_" + version);
         return url;
      }
      
      public static function ReadChars(param1:IDataInput, param2:int) : String
      {
         var _loc4_:int = 0;
         return param1.readMultiByte(param2,CHARSET);
      }
      
      public static function WriteChars(param1:IDataOutput, param2:String, param3:int) : void
      {
         var _loc4_:int = 0;
         byteBuff.allocate(param3);
         byteBuff.writeMultiByte(param2,CHARSET);
         if(param3 == 0)
         {
            param1.writeShort(byteBuff.position);
         }
         param1.writeBytes(byteBuff,0,byteBuff.position);
         if(param3 > 0)
         {
            _loc4_ = param3 - byteBuff.position;
            while(_loc4_ > 0)
            {
               param1.writeByte(0);
               _loc4_--;
            }
         }
      }
      
      public static function WriteString(param1:IDataOutput, param2:String) : void
      {
         WriteChars(param1,param2,0);
      }
      
      public static function ReadString(param1:IDataInput) : String
      {
         var _loc2_:int = int(param1.readUnsignedShort());
         return param1.readMultiByte(_loc2_,CHARSET);
      }
      
      public static function ReadPoint(param1:IDataInput) : Point
      {
         return new Point(param1.readShort(),param1.readShort());
      }
      
      public static function WritePoint(param1:IDataOutput, param2:Point) : void
      {
         param1.writeShort(param2.x);
         param1.writeShort(param2.y);
      }
      
      public static function ReadIP(param1:IDataInput) : String
      {
         var _loc2_:uint = uint(param1.readUnsignedInt());
         return (_loc2_ & 0xFF) + "." + (uint(_loc2_ >> 8) & 0xFF) + "." + (uint(_loc2_ >> 16) & 0xFF) + "." + (uint(_loc2_ >> 24) & 0xFF);
      }
      
      public static function WriteIP(param1:IDataOutput, param2:String) : void
      {
         var _loc3_:Array = param2.split(".");
         var _loc4_:uint = uint(uint(_loc3_[0]) & 0xFF | uint(_loc3_[1]) & 255 << 8 | uint(_loc3_[2]) & 255 << 16 | uint(_loc3_[3]) & 255 << 24);
         param1.writeUnsignedInt(_loc4_);
      }
      
      public static function getItemType(param1:uint, param2:int = 0) : int
      {
         if(param2 == 0)
         {
            return param1 >> 24;
         }
         return param1 >> 16 & 0x0F;
      }
   }
}

