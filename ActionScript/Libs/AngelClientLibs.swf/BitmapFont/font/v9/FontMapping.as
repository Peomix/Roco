package BitmapFont.font.v9
{
   import BitmapFont.IDispose;
   import flash.utils.ByteArray;
   
   public class FontMapping implements IDispose
   {
      
      private static const FontMappingTable_type:int = 0;
      
      private static const FontMappingArea_type:int = 1;
      
      private static const FontMappingDefault_type:int = 2;
      
      private static const FontMappingFreetype_type:int = 3;
      
      public function FontMapping()
      {
         super();
      }
      
      public static function createFontMapping(param1:ByteArray) : FontMapping
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc2_:int = int(param1.readUnsignedByte());
         if(_loc2_ == FontMapping.FontMappingArea_type)
         {
            _loc3_ = param1.readUnsignedShort();
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = param1.readUnsignedShort();
            return new FontMappingArea(_loc3_,_loc4_,_loc5_);
         }
         if(_loc2_ == FontMapping.FontMappingDefault_type)
         {
            _loc5_ = param1.readUnsignedShort();
            return new FontMappingDefault(_loc5_);
         }
         if(_loc2_ == FontMapping.FontMappingTable_type)
         {
            return new FontMappingTable(param1);
         }
         ASSERT(false,"error FontMapping type!!");
         return null;
      }
      
      public function getMappedId(param1:uint) : int
      {
         return -1;
      }
      
      public function dispose() : void
      {
      }
   }
}

import BitmapFont.util.ByteArrayUtil;
import flash.utils.ByteArray;

class FontMappingArea extends FontMapping
{
   
   private var m_minCode:uint;
   
   private var m_maxCode:uint;
   
   private var m_startId:uint;
   
   public function FontMappingArea(param1:uint, param2:uint, param3:uint)
   {
      super();
      this.m_minCode = param1;
      this.m_maxCode = param2;
      this.m_startId = param3;
      ASSERT(this.m_minCode <= this.m_maxCode,"error area!!");
   }
   
   override public function getMappedId(param1:uint) : int
   {
      if(param1 >= this.m_minCode && param1 <= this.m_maxCode)
      {
         return this.m_startId + param1 - this.m_minCode;
      }
      return -1;
   }
}

class FontMappingTable extends FontMapping
{
   
   private var m_mappingTable:Array;
   
   public function FontMappingTable(param1:ByteArray)
   {
      super();
      var _loc2_:uint = uint(ByteArrayUtil.readUnsignedByteOrShort(param1) << 1);
      this.m_mappingTable = new Array(_loc2_);
      var _loc3_:uint = 0;
      while(_loc3_ < _loc2_)
      {
         this.m_mappingTable[_loc3_] = param1.readUnsignedShort();
         _loc3_++;
      }
   }
   
   override public function getMappedId(param1:uint) : int
   {
      var _loc2_:int = 0;
      if(this.m_mappingTable)
      {
         _loc2_ = 0;
         while(_loc2_ < this.m_mappingTable.length)
         {
            if(this.m_mappingTable[_loc2_] == param1)
            {
               return this.m_mappingTable[_loc2_ + 1];
            }
            _loc2_ += 2;
         }
      }
      return -1;
   }
   
   override public function dispose() : void
   {
      if(this.m_mappingTable)
      {
         this.m_mappingTable.length = 0;
         this.m_mappingTable = null;
      }
   }
}

class FontMappingDefault extends FontMapping
{
   
   public var s_enableMappingDefault:Boolean;
   
   private var m_defaultId:uint;
   
   public function FontMappingDefault(param1:uint)
   {
      super();
      this.m_defaultId = param1;
   }
   
   override public function getMappedId(param1:uint) : int
   {
      if(this.s_enableMappingDefault)
      {
         return this.m_defaultId;
      }
      return -1;
   }
}
