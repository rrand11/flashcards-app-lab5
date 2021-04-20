package cs.mad.flashcards.adapters

import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import cs.mad.flashcards.activities.FlashCardSetDetailActivity
import cs.mad.flashcards.databinding.ItemFlashcardSetBinding
import cs.mad.flashcards.entities.FlashcardSet
import cs.mad.flashcards.entities.FlashcardSetDao

class FlashcardSetAdapter(private var dataset: List<FlashcardSet>, private val dao: FlashcardSetDao): RecyclerView.Adapter<FlashcardSetAdapter.ViewHolder>() {

    class ViewHolder(val binding: ItemFlashcardSetBinding) : RecyclerView.ViewHolder(binding.root) {
        val textView: TextView = binding.textView
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(ItemFlashcardSetBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = dataset[position]
        holder.binding.textView.text = item.title

        holder.textView.setOnClickListener {
            holder.itemView.context.startActivity(Intent(holder.itemView.context, FlashCardSetDetailActivity::class.java))
        }
    }

    override fun getItemCount(): Int {
        return dataset.size
    }

    fun setData(items: List<FlashcardSet>) {
        dataset = items
        notifyDataSetChanged()
    }
}



