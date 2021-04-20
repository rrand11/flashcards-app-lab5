

package cs.mad.flashcards.activities
/*
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import cs.mad.flashcards.R
import cs.mad.flashcards.entities.Flashcard
import cs.mad.flashcards.entities.getHardcodedFlashcards

class StudySetActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_study_set)
        var missed = 0
        var correct = 0
        var completed = 0
        var index = 0
        val lastindex = 11

        val textBox = findViewById(R.id.card_text) as TextView
        val missedcount = findViewById(R.id.missed) as TextView
        val correctcount = findViewById(R.id.correct) as TextView
        val completedcount = findViewById(R.id.completed) as TextView

        val studylist = getHardcodedFlashcards()
        var QandA = studylist.elementAt(index) // QandA is both the question and answer at the given index

        // shows first flashcard term
        textBox.text = studylist.elementAt(index).question

        // shows first flashcard definition when term is clicked
        textBox.setOnClickListener {
            val listanswer = getHardcodedFlashcards()
            textBox.text = listanswer.elementAt(index).answer
        }

        // QandA pair taken from the front of the study list and moved to the back
        val skipbutton = findViewById(R.id.skip_button) as Button
        skipbutton.setOnClickListener {

            QandA.skippedbool = true

            index = index +1

            textBox.text = studylist.elementAt(index).question
            QandA = studylist.elementAt(index)
        }

        // +1 to missed count and QandA pair taken from the front of the study list and moved to the back
        val missedbutton = findViewById(R.id.missed_button) as Button
        missedbutton.setOnClickListener {

            QandA.missedbool = true

            missed = missed +1
            missedcount.text = "Missed $missed"

            index = index +1

            textBox.text = studylist.elementAt(index).question
            QandA = studylist.elementAt(index)
        }

        // +1 to correct count, +1 to completed count and QandA pair is removed from the study list
        val correctbutton = findViewById(R.id.correct_button) as Button
        correctbutton.setOnClickListener {

            if (QandA.missedbool == false) {
                correct = correct + 1
                correctcount.text = "Correct: $correct"
            }else {
                correct = correct
            }

            completed = completed+1
            completedcount.text = "Completed: $completed"

            studylist.remove(QandA)
            textBox.text = studylist.elementAt(index).question

            index = index
            QandA = studylist.elementAt(index)
        }


        val exitbutton = findViewById(R.id.exit_button) as Button
        exitbutton.setOnClickListener {
            finish()
        }
    }
}
*/
