package poly.service;

import java.util.List;

import poly.dto.JobIntrvReviewDTO;

public interface IJobIntrvReviewService {

	List<JobIntrvReviewDTO> getReviewList() throws Exception;

	JobIntrvReviewDTO getReviewDetail(String reviewNo) throws Exception;

	int insertReview(JobIntrvReviewDTO jirDTO) throws Exception;

	int updateReview(JobIntrvReviewDTO jirDTO) throws Exception;

	int deleteReview(String targetReviewNo) throws Exception;


}
