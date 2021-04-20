package cs.mad.flashcards.entities

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(entities = [Flashcard::class,FlashcardSet::class], version = 1)
abstract class FlashcardSetsDB: RoomDatabase() {
    abstract fun setDao(): FlashcardSetDao

    companion object {
        // Singleton prevents multiple instances of database opening at the same time.
        @Volatile
        private var INSTANCE: FlashcardSetsDB? = null

        fun getDatabase(context: Context): FlashcardSetsDB {

            // if the INSTANCE is not null, then return it,
            // if it is, then create the database
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    FlashcardSetsDB::class.java,
                    "app_database"
                ).allowMainThreadQueries().build()
                INSTANCE = instance
                return instance
                instance
            }
        }
    }
}