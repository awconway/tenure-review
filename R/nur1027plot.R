

#' @importFrom dplyr tribble
#' @importFrom ggplot2 ggplot aes geom_col scale_fill_manual theme_minimal theme element_blank element_text scale_y_discrete labs
#' @importFrom stringr str_wrap
#' @export 
create_nur1027plot <- function() {

data <- tribble(
  ~number, ~question, ~rating, ~year,
  1, "I found the course intellectually stimulating", 4, "2019",
  1, "I found the course intellectually stimulating", 5, "2020",
  2, "The course provided me with a deeper understanding of the subject matter.", 4, "2019",
  2, "The course provided me with a deeper understanding of the subject matter.", 5, "2020",
  3, "The instructor created an atmosphere that was conducive to my learning.", 4, "2019",
  3, "The instructor created an atmosphere that was conducive to my learning.", 5, "2020",
  4, "Course projects, assignments, tests, and/or exams improved my understanding of the course material.", 4, "2019",
  4, "Course projects, assignments, tests, and/or exams improved my understanding of the course material.", 5, "2020",
  5, "Course projects, assignments, tests and/or exams provided opportunity for me to demonstrate an understanding of the course material.", 4, "2019",
  5, "Course projects, assignments, tests and/or exams provided opportunity for me to demonstrate an understanding of the course material.", 5, "2020",
  6, "Overall, the quality of my learning experience in this course was….", 4, "2019",
  6, "Overall, the quality of my learning experience in this course was….", 5, "2020",
  9, "This course helped me progress toward achievement of my educational goals.", 4, "2019",
  9, "This course helped me progress toward achievement of my educational goals.", 5, "2020",
  10, "The course environment promoted a supportive community for learning.", 4, "2019",
  10, "The course environment promoted a supportive community for learning.", 5, "2020",
)
data %>%
  ggplot(aes(y = reorder(question, -number), x = rating, fill = year)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#CCE2FF", "#002a60")) + ## light is hsl(214,100%,90%)
  theme_minimal() +
  theme(
    legend.position = "bottom",
    legend.title = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_blank(),
    plot.caption = element_text(hjust = 0, face = "italic"),
    plot.title.position = "plot",
    plot.caption.position = "plot") +
  scale_y_discrete(labels = function(x) str_wrap(x, width = 40)) +
  labs(
    caption = "1=Poor/Not at all, 2=Fair/Somewhat, 3=Good/Moderately, 4=Very Good/Mostly, 5=Excellent/A great deal",
    subtitle = "Median scores for core and divisional items in 2019 (n=22) and 2020 (n=23)"
  )

}
