package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.error.AngelError;
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class P_Query extends P_Struct implements IAngelDataInput
   {
       
      
      public var code:P_ReturnCode;
      
      public var results:int = 0;
      
      public function P_Query(param1:Array = null)
      {
         super(param1);
      }
      
      protected function createStruct(param1:Array) : IAngelDataOutput
      {
         var _loc2_:int = int(param1[0]);
         switch(_loc2_)
         {
            case 1:
               return new QueryEmblem(int(param1[1]));
            case 2:
               return new QueryItem(param1[1],param1[2]);
            case 3:
               return new QueryAvatar(param1[1]);
            case 4:
               return new QueryVipExpire();
            case 5:
               return new QueryTitle(param1[1]);
            default:
               throw new AngelError("目前不支持此类查询",this);
         }
      }
      
      override public function fill(param1:Array) : void
      {
         var _loc4_:IAngelDataOutput = null;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if((_loc4_ = this.createStruct(param1[_loc3_])) != null)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         super.fill(_loc2_);
         len += 2;
      }
      
      override public function write(param1:IDataOutput) : void
      {
         param1.writeShort(structs.length);
         super.write(param1);
      }
      
      public function read(param1:IDataInput) : void
      {
         this.code = ProtocolHelper.ReadCode(param1);
         if(this.code.isError())
         {
            return;
         }
         var _loc2_:int = int(param1.readUnsignedShort());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(_loc3_ != 0)
            {
               this.results <<= 1;
            }
            this.results |= param1.readUnsignedByte();
            _loc3_++;
         }
      }
   }
}

import com.QQ.angel.api.net.protocol.IAngelDataOutput;
import flash.utils.IDataOutput;

class QueryEmblem implements IAngelDataOutput
{
    
   
   public var type:int = 1;
   
   public var val:int;
   
   public function QueryEmblem(param1:int = 0)
   {
      super();
      this.val = param1;
   }
   
   public function write(param1:IDataOutput) : void
   {
      param1.writeByte(this.type);
      param1.writeByte(this.val);
   }
   
   public function get length() : uint
   {
      return 2;
   }
}

import com.QQ.angel.api.net.protocol.IAngelDataOutput;
import flash.utils.IDataOutput;

class QueryItem implements IAngelDataOutput
{
    
   
   public var type:int = 2;
   
   public var id:uint;
   
   public var num:int;
   
   public function QueryItem(param1:uint = 0, param2:int = 0)
   {
      super();
      this.id = param1;
      this.num = param2;
   }
   
   public function write(param1:IDataOutput) : void
   {
      param1.writeByte(this.type);
      param1.writeUnsignedInt(this.id);
      param1.writeShort(this.num);
   }
   
   public function get length() : uint
   {
      return 7;
   }
}

import com.QQ.angel.api.net.protocol.IAngelDataOutput;
import flash.utils.IDataOutput;

class QueryAvatar implements IAngelDataOutput
{
    
   
   public var type:int = 3;
   
   public var id:uint;
   
   public function QueryAvatar(param1:uint = 0)
   {
      super();
      this.id = param1;
   }
   
   public function write(param1:IDataOutput) : void
   {
      param1.writeByte(this.type);
      param1.writeUnsignedInt(this.id);
   }
   
   public function get length() : uint
   {
      return 5;
   }
}

import com.QQ.angel.api.net.protocol.IAngelDataOutput;
import flash.utils.IDataOutput;

class QueryVipExpire implements IAngelDataOutput
{
    
   
   public var type:int = 4;
   
   public function QueryVipExpire()
   {
      super();
   }
   
   public function write(param1:IDataOutput) : void
   {
      param1.writeByte(this.type);
   }
   
   public function get length() : uint
   {
      return 1;
   }
}

import com.QQ.angel.api.net.protocol.IAngelDataOutput;
import flash.utils.IDataOutput;

class QueryTitle implements IAngelDataOutput
{
    
   
   public var type:int = 5;
   
   public var id:uint;
   
   public function QueryTitle(param1:uint = 0)
   {
      super();
      this.id = param1;
   }
   
   public function write(param1:IDataOutput) : void
   {
      param1.writeByte(this.type);
      param1.writeUnsignedInt(this.id);
   }
   
   public function get length() : uint
   {
      return 5;
   }
}
