package cs.mad.flashcards.activities

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import cs.mad.flashcards.adapters.FlashcardListAdapter
import cs.mad.flashcards.databinding.ActivityFlashCardSetDetailBinding
import cs.mad.flashcards.entities.*
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class FlashCardSetDetailActivity : AppCompatActivity() {
    private lateinit var binding: ActivityFlashCardSetDetailBinding
    private val cardDao by lazy { FlashcardDB.getDatabase(applicationContext).cardDao() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityFlashCardSetDetailBinding.inflate(layoutInflater)
        setContentView(binding.root)


        binding.CardList.adapter = FlashcardListAdapter(listOf(),cardDao)
        loadFromDb()


        binding.addCardButton.setOnClickListener {
            GlobalScope.launch {
                cardDao.insert(Flashcard(null,"Question 1", "Answer 1"))
                loadFromDb()
            }
        }

        binding.deleteCardButton.setOnClickListener {
            lifecycleScope.launch {
                finish()
            }
        }
    }

    private fun loadFromDb() {
        lifecycleScope.launch {
            (binding.CardList.adapter as FlashcardListAdapter).setData(cardDao.getAll())
        }
    }
}
