package laptopshop.service;

import laptopshop.domain.Feedback;
import laptopshop.repository.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;

    @Transactional
    public Feedback saveFeedback(Feedback feedback) {
        return feedbackRepository.save(feedback);
    }
}
