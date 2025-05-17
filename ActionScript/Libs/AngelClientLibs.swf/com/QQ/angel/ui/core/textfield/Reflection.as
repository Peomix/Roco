package com.QQ.angel.ui.core.textfield
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.system.ApplicationDomain;
   import flash.utils.getQualifiedClassName;
   
   public class Reflection
   {
      
      public function Reflection()
      {
         super();
      }
      
      public static function createMovieClipInstance(param1:String, param2:ApplicationDomain = null) : MovieClip
      {
         var mc:MovieClip = null;
         var fullClassName:String = param1;
         var applicationDomain:ApplicationDomain = param2;
         try
         {
            mc = createInstance(fullClassName,applicationDomain);
         }
         catch(e:*)
         {
            mc = new MovieClip();
         }
         if(null == mc)
         {
            mc = new MovieClip();
         }
         return mc;
      }
      
      public static function createSimpleButtonInstance(param1:String, param2:ApplicationDomain = null) : SimpleButton
      {
         var button:SimpleButton = null;
         var fullClassName:String = param1;
         var applicationDomain:ApplicationDomain = param2;
         try
         {
            button = createInstance(fullClassName,applicationDomain);
         }
         catch(e:*)
         {
            button = new SimpleButton();
         }
         if(null == button)
         {
            button = new SimpleButton();
         }
         return button;
      }
      
      public static function createSpriteInstance(param1:String, param2:ApplicationDomain = null) : Sprite
      {
         var button:Sprite = null;
         var fullClassName:String = param1;
         var applicationDomain:ApplicationDomain = param2;
         try
         {
            button = createInstance(fullClassName,applicationDomain);
         }
         catch(e:*)
         {
            button = new Sprite();
         }
         if(null == button)
         {
            button = new Sprite();
         }
         return button;
      }
      
      public static function createBitmapDataInstance(param1:String, param2:int = 0, param3:int = 0, param4:ApplicationDomain = null) : *
      {
         var assetClass:Class = null;
         var data:BitmapData = null;
         var fullClassName:String = param1;
         var width:int = param2;
         var height:int = param3;
         var applicationDomain:ApplicationDomain = param4;
         try
         {
            assetClass = getClass(fullClassName,applicationDomain);
            if(assetClass != null)
            {
               data = new assetClass(width,height);
            }
         }
         catch(e:*)
         {
            data = new BitmapData(width > 0 ? width : 1,height > 0 ? height : 1);
         }
         if(null == data)
         {
            data = new BitmapData(width > 0 ? width : 1,height > 0 ? height : 1);
         }
         return data;
      }
      
      public static function createInstance(param1:String, param2:ApplicationDomain = null) : *
      {
         var assetClass:Class = null;
         var fullClassName:String = param1;
         var applicationDomain:ApplicationDomain = param2;
         try
         {
            assetClass = getClass(fullClassName,applicationDomain);
            if(assetClass != null)
            {
               return new assetClass();
            }
         }
         catch(e:*)
         {
            trace(e);
         }
         return null;
      }
      
      public static function getClass(param1:String, param2:ApplicationDomain = null) : Class
      {
         var _loc3_:Class = null;
         if(param2 == null)
         {
            param2 = ApplicationDomain.currentDomain;
         }
         try
         {
            _loc3_ = param2.getDefinition(param1) as Class;
         }
         catch(e:*)
         {
         }
         return _loc3_;
      }
      
      public static function getFullClassName(param1:*) : String
      {
         return getQualifiedClassName(param1);
      }
      
      public static function getClassName(param1:*) : String
      {
         var _loc2_:String = getFullClassName(param1);
         var _loc3_:int = int(_loc2_.lastIndexOf("."));
         if(_loc3_ >= 0)
         {
            _loc2_ = _loc2_.substr(_loc3_ + 1);
         }
         return _loc2_;
      }
      
      public static function getPackageName(param1:*) : String
      {
         var _loc2_:String = getFullClassName(param1);
         var _loc3_:int = int(_loc2_.lastIndexOf("."));
         if(_loc3_ >= 0)
         {
            return _loc2_.substring(0,_loc3_);
         }
         return "";
      }
   }
}

