package cs.mad.flashcards.entities

import androidx.room.*

data class CodedFlashCard(val flashcard: List<Flashcard>)
@Entity
data class Flashcard(@PrimaryKey(autoGenerate = true) val myId: Long?, var question: String, var answer: String)
    @Dao
    interface FlashcardDao {
        @Query("select * from Flashcard order by lower(question) asc")
        fun getAll(): List<Flashcard>

        @Insert
        fun insert(vararg flaashcards: Flashcard)

        @Insert
        fun insert(flaashcards: List<Flashcard>)

        @Update
        fun update(flaashcards: Flashcard)

        @Delete
        fun delete(flaashcards: Flashcard)
}