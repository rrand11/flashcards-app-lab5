package cs.mad.flashcards.adapters

import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.EditText
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import cs.mad.flashcards.activities.FlashCardSetDetailActivity
import cs.mad.flashcards.databinding.FlashcardItemBinding
import cs.mad.flashcards.entities.Flashcard
import cs.mad.flashcards.entities.FlashcardDao
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class FlashcardListAdapter(private var dataset: List<Flashcard>, private val dao: FlashcardDao): RecyclerView.Adapter<FlashcardListAdapter.ViewHolder>()
{
    class ViewHolder(val binding: FlashcardItemBinding) : RecyclerView.ViewHolder(binding.root) {
        val textView: TextView = binding.textView
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(FlashcardItemBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = dataset[position]
        holder.binding.textView.text = item.question
        holder.textView.setOnClickListener {
            holder.itemView.context.startActivity(Intent(holder.itemView.context, FlashCardSetDetailActivity::class.java))
        }

        holder.itemView.setOnClickListener {
            AlertDialog.Builder(it.context)
                    .setTitle(item.question)
                    .setMessage(item.answer)
                    .setNegativeButton("Delete") { _, _ ->
                        GlobalScope.launch {
                            dao.delete(item)
                            GlobalScope.launch(Dispatchers.Main) {
                                setData(dao.getAll())
                            }
                        }
                    }
                    .setPositiveButton("Done") { _, _ -> }
                    .setNeutralButton("Edit") { _, _ -> showCustomDialog(holder.itemView.context, item) }
                    .create()
                    .show()
        }
    }

    fun showCustomDialog(context: Context, item: Flashcard) {
        val title = EditText(context)
        val body = EditText(context)
        title.setText(item.question)
        body.setText(item.answer)
        AlertDialog.Builder(context)
                .setCustomTitle(title)
                .setView(body)
                .setPositiveButton("Save") { _, _ -> GlobalScope.launch { item.question = title.text.toString()
                    dao.update(item)
                    GlobalScope.launch(Dispatchers.Main) { setData(dao.getAll()) }
                } }
                .create()
                .show()
    }
    override fun getItemCount(): Int {
        return dataset.size
    }

    fun setData(items: List<Flashcard>) {
        dataset = items
        notifyDataSetChanged()
    }
}