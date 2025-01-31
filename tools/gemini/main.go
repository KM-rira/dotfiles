package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
)

// ContentPart represents a part of the content.
type ContentPart struct {
	Text string `json:"text"`
}

// Content represents the content structure.
type Content struct {
	Parts []ContentPart `json:"parts"`
}

// GenerateContentRequest represents the API request structure.
type GenerateContentRequest struct {
	Contents []Content `json:"contents"`
}

// GenerateContentResponse represents the API response structure.
type GenerateContentResponse struct {
	Candidates []struct {
		Content struct {
			Parts []struct {
				Text string `json:"text"`
			} `json:"parts"`
			Role string `json:"role"`
		} `json:"content"`
		FinishReason     string `json:"finishReason"`
		CitationMetadata struct {
			CitationSources []struct {
				StartIndex int    `json:"startIndex"`
				EndIndex   int    `json:"endIndex"`
				URI        string `json:"uri"`
			} `json:"citationSources"`
		} `json:"citationMetadata"`
		AvgLogprobs float64 `json:"avgLogprobs"`
	} `json:"candidates"`
	UsageMetadata struct {
		PromptTokenCount     int `json:"promptTokenCount"`
		CandidatesTokenCount int `json:"candidatesTokenCount"`
		TotalTokenCount      int `json:"totalTokenCount"`
	} `json:"usageMetadata"`
	ModelVersion string `json:"modelVersion"`
}

func main() {
	apiKey := os.Getenv("GEMINI_API_KEY")
	if "" == apiKey {
		fmt.Println("Please set GEMINI_API_KEY")
		return
	}

	// cliの引数を取得する。go run main.go "Do you konw japanese?" と実行すると、"Do you konw japanese?" が取得できる
	args := os.Args[1:]
	if len(args) <= 0 {
		fmt.Println("Please set request text")
		return
	}
	requestText := strings.Join(args, " ")

	ctx := context.Background()
	client, err := genai.NewClient(ctx, option.WithAPIKey(apiKey))
	if err != nil {
		log.Fatal(err)
	}
	defer client.Close()

	// [START text_gen_text_only_prompt]
	model := client.GenerativeModel("gemini-1.5-flash")
	resp, err := model.GenerateContent(ctx, genai.Text(requestText))
	if err != nil {
		fmt.Println(err)
		return
	}

	printResponse(resp)
}

func printResponse(resp *genai.GenerateContentResponse) {
	for _, cand := range resp.Candidates {
		if cand.Content != nil {
			for _, part := range cand.Content.Parts {
				fmt.Println(part)
			}
		}
	}
}
