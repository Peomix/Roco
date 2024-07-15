package com.QQ.angel.ui.sysicons
{
   import flash.geom.Point;
   
   public interface ISysIconGroup
   {
       
      
      function addSysIcon(param1:ISysIcon) : ISysIcon;
      
      function addSysIconAt(param1:ISysIcon, param2:int) : ISysIcon;
      
      function addIcon(param1:SysIconData) : ISysIcon;
      
      function addIconAt(param1:SysIconData, param2:int) : ISysIcon;
      
      function addIconBetween(param1:SysIconData, param2:String, param3:String) : ISysIcon;
      
      function removeIcon(param1:ISysIcon) : Boolean;
      
      function removeIconAt(param1:int) : Boolean;
      
      function getIconAt(param1:int) : ISysIcon;
      
      function clearIcons() : void;
      
      function getIconsNum() : uint;
      
      function getSysIconByToolTip(param1:String) : ISysIcon;
      
      function getSysIconPosByToolTip(param1:String) : Point;
      
      function refreshIcons(param1:Array, param2:Array) : void;
   }
}
