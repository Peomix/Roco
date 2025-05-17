package com.QQ.angel.ui.sysicons
{
   public interface ISysIconManager
   {
      
      function dispose() : void;
      
      function get topLeftIcons() : ISysIconGroup;
      
      function get topRightIcons() : ISysIconGroup;
      
      function get newWorldIcons() : ISysIconGroup;
      
      function showAllIcons() : void;
      
      function hideAllIcons() : void;
      
      function updateIconsBetweenNewAndOldWorld() : void;
   }
}

