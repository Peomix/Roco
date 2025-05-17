package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class PetInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
      
      public var innate_full_hp:uint;
      
      public var level:uint;
      
      public var innate_near_attack:uint;
      
      public var innate_speed:uint;
      
      public var postnatal_far_armor:uint;
      
      public var far_armor:uint;
      
      public var id:uint;
      
      public var postnatal_far_attack:uint;
      
      public var postnatal_near_armor:uint;
      
      public var postnatal_speed:uint;
      
      public var full_hp:uint;
      
      public var near_attack:uint;
      
      public var speed:uint;
      
      public var catch_time:uint;
      
      public var innate_near_armor:uint;
      
      public var innate_far_armor:uint;
      
      public var postnatal_full_hp:uint;
      
      public var innate_far_attack:uint;
      
      public var near_armor:uint;
      
      public var postnatal_near_attack:uint;
      
      public var far_attack:uint;
      
      public function PetInfo()
      {
         super();
      }
      
      public function encodeCGI() : String
      {
         return "" + "&id=" + id + "&catch_time=" + catch_time + "&level=" + level + "&full_hp=" + full_hp + "&near_attack=" + near_attack + "&near_armor=" + near_armor + "&far_attack=" + far_attack + "&far_armor=" + far_armor + "&speed=" + speed + "&innate_full_hp=" + innate_full_hp + "&innate_near_attack=" + innate_near_attack + "&innate_near_armor=" + innate_near_armor + "&innate_far_attack=" + innate_far_attack + "&innate_far_armor=" + innate_far_armor + "&innate_speed=" + innate_speed + "&postnatal_full_hp=" + postnatal_full_hp + "&postnatal_near_attack=" + postnatal_near_attack + "&postnatal_near_armor=" + postnatal_near_armor + "&postnatal_far_attack=" + postnatal_far_attack + "&postnatal_far_armor=" + postnatal_far_armor + "&postnatal_speed=" + postnatal_speed;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeShort(id);
         param1.writeInt(catch_time);
         param1.writeByte(level);
         param1.writeShort(full_hp);
         param1.writeShort(near_attack);
         param1.writeShort(near_armor);
         param1.writeShort(far_attack);
         param1.writeShort(far_armor);
         param1.writeShort(speed);
         param1.writeShort(innate_full_hp);
         param1.writeShort(innate_near_attack);
         param1.writeShort(innate_near_armor);
         param1.writeShort(innate_far_attack);
         param1.writeShort(innate_far_armor);
         param1.writeShort(innate_speed);
         param1.writeShort(postnatal_full_hp);
         param1.writeShort(postnatal_near_attack);
         param1.writeShort(postnatal_near_armor);
         param1.writeShort(postnatal_far_attack);
         param1.writeShort(postnatal_far_armor);
         param1.writeShort(postnatal_speed);
         return true;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            id = uint(param1.id.text());
            catch_time = uint(param1.catch_time.text());
            level = uint(param1.level.text());
            full_hp = uint(param1.full_hp.text());
            near_attack = uint(param1.near_attack.text());
            near_armor = uint(param1.near_armor.text());
            far_attack = uint(param1.far_attack.text());
            far_armor = uint(param1.far_armor.text());
            speed = uint(param1.speed.text());
            innate_full_hp = uint(param1.innate_full_hp.text());
            innate_near_attack = uint(param1.innate_near_attack.text());
            innate_near_armor = uint(param1.innate_near_armor.text());
            innate_far_attack = uint(param1.innate_far_attack.text());
            innate_far_armor = uint(param1.innate_far_armor.text());
            innate_speed = uint(param1.innate_speed.text());
            postnatal_full_hp = uint(param1.postnatal_full_hp.text());
            postnatal_near_attack = uint(param1.postnatal_near_attack.text());
            postnatal_near_armor = uint(param1.postnatal_near_armor.text());
            postnatal_far_attack = uint(param1.postnatal_far_attack.text());
            postnatal_far_armor = uint(param1.postnatal_far_armor.text());
            postnatal_speed = uint(param1.postnatal_speed.text());
            return true;
         }
         return false;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "PetInfo";
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         id = param1.readUnsignedShort();
         catch_time = param1.readUnsignedInt();
         level = param1.readUnsignedByte();
         full_hp = param1.readUnsignedShort();
         near_attack = param1.readUnsignedShort();
         near_armor = param1.readUnsignedShort();
         far_attack = param1.readUnsignedShort();
         far_armor = param1.readUnsignedShort();
         speed = param1.readUnsignedShort();
         innate_full_hp = param1.readUnsignedShort();
         innate_near_attack = param1.readUnsignedShort();
         innate_near_armor = param1.readUnsignedShort();
         innate_far_attack = param1.readUnsignedShort();
         innate_far_armor = param1.readUnsignedShort();
         innate_speed = param1.readUnsignedShort();
         postnatal_full_hp = param1.readUnsignedShort();
         postnatal_near_attack = param1.readUnsignedShort();
         postnatal_near_armor = param1.readUnsignedShort();
         postnatal_far_attack = param1.readUnsignedShort();
         postnatal_far_armor = param1.readUnsignedShort();
         postnatal_speed = param1.readUnsignedShort();
         return true;
      }
   }
}

