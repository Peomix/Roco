package com.QQ.angel.install.config.zip
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import flash.utils.IDataInput;
   
   public class ZipFile
   {
       
      
      private var entryTable:Dictionary;
      
      private var entryList:Array;
      
      private var buf:ByteArray;
      
      private var locOffsetTable:Dictionary;
      
      public function ZipFile(param1:IDataInput)
      {
         super();
         buf = new ByteArray();
         buf.endian = Endian.LITTLE_ENDIAN;
         param1.readBytes(buf);
         readEntries();
      }
      
      public function get size() : uint
      {
         return entryList.length;
      }
      
      private function findEND() : uint
      {
         var _loc1_:uint = uint(buf.length - ZipConstants.ENDHDR);
         var _loc2_:uint = Math.max(0,_loc1_ - 65535);
         while(_loc1_ >= _loc2_)
         {
            if(buf[_loc1_] == 80)
            {
               buf.position = _loc1_;
               if(buf.readUnsignedInt() == ZipConstants.ENDSIG)
               {
                  return _loc1_;
               }
            }
            _loc1_--;
         }
         throw new ZipError("invalid zip");
      }
      
      private function readEND() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.endian = Endian.LITTLE_ENDIAN;
         buf.position = findEND();
         buf.readBytes(_loc1_,0,ZipConstants.ENDHDR);
         _loc1_.position = ZipConstants.ENDTOT;
         entryList = new Array(_loc1_.readUnsignedShort());
         _loc1_.position = ZipConstants.ENDOFF;
         buf.position = _loc1_.readUnsignedInt();
      }
      
      private function readEntries() : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:ZipEntry = null;
         readEND();
         entryTable = new Dictionary();
         locOffsetTable = new Dictionary();
         var _loc1_:uint = 0;
         while(_loc1_ < entryList.length)
         {
            _loc2_ = new ByteArray();
            _loc2_.endian = Endian.LITTLE_ENDIAN;
            buf.readBytes(_loc2_,0,ZipConstants.CENHDR);
            if(_loc2_.readUnsignedInt() != ZipConstants.CENSIG)
            {
               throw new ZipError("invalid CEN header (bad signature)");
            }
            _loc2_.position = ZipConstants.CENNAM;
            _loc3_ = _loc2_.readUnsignedShort();
            if(_loc3_ == 0)
            {
               throw new ZipError("missing entry name");
            }
            _loc4_ = new ZipEntry(buf.readUTFBytes(_loc3_));
            _loc3_ = _loc2_.readUnsignedShort();
            _loc4_.extra = new ByteArray();
            if(_loc3_ > 0)
            {
               buf.readBytes(_loc4_.extra,0,_loc3_);
            }
            buf.position += _loc2_.readUnsignedShort();
            _loc2_.position = ZipConstants.CENVER;
            _loc4_.version = _loc2_.readUnsignedShort();
            _loc4_.flag = _loc2_.readUnsignedShort();
            if((_loc4_.flag & 1) == 1)
            {
               throw new ZipError("encrypted ZIP entry not supported");
            }
            _loc4_.method = _loc2_.readUnsignedShort();
            _loc4_.dostime = _loc2_.readUnsignedInt();
            _loc4_.crc = _loc2_.readUnsignedInt();
            _loc4_.compressedSize = _loc2_.readUnsignedInt();
            _loc4_.size = _loc2_.readUnsignedInt();
            entryList[_loc1_] = _loc4_;
            entryTable[_loc4_.name] = _loc4_;
            _loc2_.position = ZipConstants.CENOFF;
            locOffsetTable[_loc4_.name] = _loc2_.readUnsignedInt();
            _loc1_++;
         }
      }
      
      public function getInput(param1:ZipEntry) : ByteArray
      {
         var _loc4_:ByteArray = null;
         var _loc5_:Inflater = null;
         buf.position = locOffsetTable[param1.name] + ZipConstants.LOCHDR - 2;
         var _loc2_:uint = uint(buf.readShort());
         buf.position += param1.name.length + _loc2_;
         var _loc3_:ByteArray = new ByteArray();
         if(param1.compressedSize > 0)
         {
            buf.readBytes(_loc3_,0,param1.compressedSize);
         }
         switch(param1.method)
         {
            case ZipConstants.STORED:
               return _loc3_;
            case ZipConstants.DEFLATED:
               _loc4_ = new ByteArray();
               (_loc5_ = new Inflater()).setInput(_loc3_);
               _loc5_.inflate(_loc4_);
               return _loc4_;
            default:
               throw new ZipError("invalid compression method");
         }
      }
      
      public function get entries() : Array
      {
         return entryList;
      }
      
      public function getEntry(param1:String) : ZipEntry
      {
         return entryTable[param1];
      }
   }
}
