package demo;

import java.io.IOException;
import java.util.StringTokenizer;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class WordCount 
{
	public static class Map extends Mapper<LongWritable, Text,Text,IntWritable>
	{
		public void map(LongWritable key,Text value, Context context)throws IOException,InterruptedException
		{
			String line=value.toString();
			StringTokenizer tokenizer=new StringTokenizer(line);
			while(tokenizer.hasMoreTokens())
			{
				value.set(tokenizer.nextToken());
				context.write(value,new IntWritable(1));
			}
		}
	}
	public static class Reduce extends Reducer<Text,IntWritable,Text,IntWritable>
	{
		public void reduce(Text key,Iterable<IntWritable> values, Context context)throws IOException, InterruptedException	
		{
			int sum=0;
			for (IntWritable x:values)
			{
				sum+=x.get();
			}
			context.write(key, new IntWritable(sum));
		}
	}
	public static void main(String[] args) throws Exception
	{	
		Configuration conf = new Configuration();
		
		Job job = new Job(conf);
					
		job.setJarByClass(WordCount.class); 
		job.setMapperClass(Map.class); 
		job.setReducerClass(Reduce.class);
	
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		
		Path outputPath=new Path(args[1]);
		
		FileInputFormat.addInputPath(job, new Path(args[0]));		
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		
		outputPath.getFileSystem(conf).delete(outputPath, true);
		
		System.exit(job.waitForCompletion(true) ? 0 : 1);
		
	}
}
