package cs.mad.flashcards.entities

import androidx.room.*

data class CodedFlashCardSet(val flashcardsets: List<FlashcardSet>)

@Entity
data class FlashcardSet(@PrimaryKey(autoGenerate = true) val myId: Long?, var title: String?)
    @Dao
    interface FlashcardSetDao {
        @Query("select * from FlashcardSet order by lower(title) asc")
        fun getAll(): List<FlashcardSet>

        @Insert
        fun insert(vararg flashcardset: FlashcardSet)

        @Insert
        fun insert(flashcardset: List<FlashcardSet>)

        @Update
        fun update(flashcardset: FlashcardSet)

        @Delete
        fun delete(flashcardset: FlashcardSet)
    }