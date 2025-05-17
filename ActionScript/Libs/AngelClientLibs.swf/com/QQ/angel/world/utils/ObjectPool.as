package com.QQ.angel.world.utils
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class ObjectPool
   {
      
      public static var MAX_POOLING_SIZE:int = 50;
      
      private static var pools:Dictionary = new Dictionary(false);
      
      private static var dicPools:Dictionary = new Dictionary(false);
      
      public function ObjectPool()
      {
         super();
      }
      
      private static function getPool(param1:Class) : Array
      {
         return param1 in pools ? pools[param1] : (pools[param1] = []);
      }
      
      private static function getDicPool(param1:Class) : Dictionary
      {
         return param1 in dicPools ? dicPools[param1] : (dicPools[param1] = new Dictionary());
      }
      
      public static function getObject(param1:Class, ... rest) : *
      {
         var _loc5_:* = undefined;
         var _loc3_:Array = getPool(param1);
         var _loc4_:Dictionary = getDicPool(param1);
         if(_loc3_.length > 0)
         {
            _loc5_ = _loc3_.pop();
            if(_loc5_ in _loc4_)
            {
               delete _loc4_[_loc5_];
            }
         }
         else
         {
            _loc5_ = construct(param1,rest);
         }
         return _loc5_;
      }
      
      private static function construct(param1:Class, param2:Array) : *
      {
         switch(param2.length)
         {
            case 0:
               return new param1();
            case 1:
               return new param1(param2[0]);
            case 2:
               return new param1(param2[0],param2[1]);
            case 3:
               return new param1(param2[0],param2[1],param2[2]);
            case 4:
               return new param1(param2[0],param2[1],param2[2],param2[3]);
            case 5:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
            case 6:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
            case 7:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
            case 8:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
            case 9:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
            case 10:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
            default:
               return null;
         }
      }
      
      public static function disposeObject(param1:*, param2:Class = null) : void
      {
         var dic:Dictionary;
         var pool:Array;
         var typeName:String = null;
         var object:* = param1;
         var type:Class = param2;
         if(!type)
         {
            typeName = getQualifiedClassName(object);
            try
            {
               type = getDefinitionByName(typeName) as Class;
            }
            catch(e:*)
            {
               return;
            }
         }
         dic = getDicPool(type);
         if(object in dic)
         {
            return;
         }
         pool = getPool(type);
         if(pool.length < MAX_POOLING_SIZE)
         {
            pool.push(object);
            dic[object] = true;
         }
      }
      
      public static function clearAllObjectByClass(param1:Class) : void
      {
         if(pools.hasOwnProperty(param1))
         {
            delete pools[param1];
         }
         if(dicPools.hasOwnProperty(param1))
         {
            delete dicPools[param1];
         }
      }
      
      public static function releaseAllRefrence() : void
      {
         pools = new Dictionary(false);
         dicPools = new Dictionary(false);
      }
   }
}

