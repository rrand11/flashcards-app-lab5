package cs.mad.flashcards.activities

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import cs.mad.flashcards.adapters.FlashcardSetAdapter
import cs.mad.flashcards.databinding.ActivityMainBinding
import cs.mad.flashcards.entities.*
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

/*
Main Activity is the recycler view that holds the first screen - the list od set of flashcards
It also includes a button to add another set and the listener for when that button is clicked
Add Button clicked calls the add function in FlashcardSetAdapter to add another set to the list

XML = actvity_main
Adapter = FlashcardSetAdapter - holds the set title and listener for when the set is clicked
 */

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private val setDao by lazy {FlashcardSetsDB.getDatabase(applicationContext).setDao() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.recyclerView.adapter = FlashcardSetAdapter(listOf(),setDao)
        loadFromDb()

        binding.addSetButton.setOnClickListener {
            GlobalScope.launch {
                setDao.insert(FlashcardSet(null,"New Set"))
                loadFromDb()
            }
        }
    }

    private fun loadFromDb() {
        lifecycleScope.launch {
            (binding.recyclerView.adapter as FlashcardSetAdapter).setData(setDao.getAll())
        }
    }
}