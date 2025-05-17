package com.QQ.angel.data
{
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.data.entity.ItemDataDes;
   
   public interface IAngelItemDataProxy extends IDataProxy
   {
      
      function get itemLength() : int;
      
      function selectItem(param1:int) : ItemDataDes;
      
      function selectItems(param1:int = 0, param2:int = 0) : Array;
      
      function selectItemsByID(param1:Array) : Array;
   }
}

