package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.JobIntrvReviewDTO;

@Mapper("JobIntrvReviewMapper")
public interface JobIntrvReviewMapper {

	List<JobIntrvReviewDTO> getReviewList() throws Exception;

	JobIntrvReviewDTO getReviewDetail(String reviewNo) throws Exception;

	int insertReview(JobIntrvReviewDTO jirDTO) throws Exception;

	int updateReview(JobIntrvReviewDTO jirDTO) throws Exception;

	int deleteReview(String targetReviewNo) throws Exception;

	
}
