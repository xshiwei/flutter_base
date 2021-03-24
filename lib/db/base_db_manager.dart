
abstract class BaseDbManager{
   init();

   getCurrentDatabase();

   close();

   isTableExits(String tableName);
}